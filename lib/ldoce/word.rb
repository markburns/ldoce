module Ldoce
  class Word
    include HTTParty

    attr_reader :query, :response

    def initialize query, response
      @query, @response  = query, response
    end

    def word
      query
    end

    def play
      if mp3?
        unless File.exists? filename
          command = "curl #{mp3_url} -silent > #{filename}"
          `#{command}`
        end
        `afplay #{filename}`
      end
      self
    end

    def mp3?
      !!mp3_url
    end

    def entries
      entries = response["Entries"]
      entries = entries["Entry"] rescue []
      arrayify entries
    end

    def definition
      definitions = each_in entries  do |entry|
        each_in entry["Sense"] do |f|
          if f["DEF"]
            f["DEF"]["#text"]
          elsif f["Subsense"]
            each_in f["Subsense"] do |g|
              g["DEF"]["#text"]
            end
          end
        end
      end.flatten.compact

      definitions.map { |e| "\"#{e}\"" }.join(",")
    end

    def inspect
      "<Word #{@query}: #{definition} mp3:#{mp3?}>"
    end

    def american_pronunciations
      entries.map{|e| ["multimedia"].detect{|w| w["@type"]=="US_PRON"}["@href"]}
    end

    def british_pronunciations
      entries.map{|e| e["multimedia"].detect{|w| w["@type"]=="GB_PRON"}["@href"]}
    end

    def mp3_url
      pronunciation = british_pronunciations.first || american_pronunciations.first
      url = "https://api.pearson.com/longman/dictionary#{pronunciation}?apikey=#{Word.api_key}"
    rescue
      nil
    end

    private

    def arrayify hash_or_array
      hash_or_array.is_a?(Hash) ? [hash_or_array] : hash_or_array
    end

    def each_in hash_or_array
      arrayify(hash_or_array).map do |el|
        yield el
      end
    end

    def filename lang="british"
      "tmp/#{lang}_#{query}.mp3"
    end

    class MissingApiKey < Exception; end
    class << self
      def play query
        search(query).play
      end

      def find query
        search query
      end

      def search query
        response = get(url(query)).parsed_response
        Word.new query, response
      end

      attr_writer :api_key

      def api_key
        @api_key ||= YAML.load(File.read "api_key.yml")["api_key"]
      rescue
        raise MissingApiKey.new "Either set the API key programmatically:
Ldoce::Word.api_key = '<your_key>'

or

Create a file called api_key.yml and add your Longman API Key:
api_key: <your_key_here>"
      end

      def url query
        "https://api.pearson.com/longman/dictionary/entry.json?q=#{query}&apikey=#{api_key}"
      end
    end
  end
end

