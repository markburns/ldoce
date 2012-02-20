require File.expand_path('spec/spec_helper')

describe Ldoce::Word do
  before do
    VCR.use_cassette('initialize_no_scheme') do
      @cat = Ldoce::Word.search 'cat'
    end
  end

  describe "#definitions" do
    it "gets the parsed response" do
      @cat.definitions.first.should == "a small animal with four legs that people often keep as a pet."
    end
  end

  describe "#play" do
    specify { ->{@cat.play}.should_not raise_error }
  end
end
