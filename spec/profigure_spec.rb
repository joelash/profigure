require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Profigure" do
  before :all do
    @config_dir = File.join(File.dirname(__FILE__), "test_config")
  end

  it "loads from defaults" do
    config = Profigure.load @config_dir

    config.foo.should == "bar"
  end

  it "also loads from your environment" do
    config = Profigure.load @config_dir, "test"

    config.another.should == "example"
  end

  it "should override defaults with keys in env file" do
    config = Profigure.load @config_dir, "overrides"

    config.foo.should == "overridden"
  end

  it "should not die if file is empty" do
    lambda { Profigure.load @config_dir, "empty" }.should_not raise_error
  end

  it "should properly handle nested hashes" do
    config = Profigure.load @config_dir, "nested"

    config.top_level.second_level.third_level.bar.should == "baz"
  end

  it "should properly handle arrays" do
    config = Profigure.load @config_dir, "arrays"

    config.array.size.should == 2
    config.array[1].should == "two"
  end

  it "should properly handle inline arrays" do
    config = Profigure.load @config_dir, "arrays"

    config.inline_array.size.should == 3
    config.inline_array.last.should == "five"
  end

  it "should allow overriding after load" do
    config = Profigure.load @config_dir, "test"
    config.foo = "bar"

    config.foo.should == "bar"
  end

  it "should allow reading via hash notation" do
    config = Profigure.load @config_dir, "test"

    config[:foo].should == "bar"
  end

  it "should allow template to contain erb" do
    config = Profigure.load @config_dir, "erb"

    config[:user].should == ENV["USER"]
  end

  context "profiguring like another yml" do
    before :all do
      @config = Profigure.load @config_dir, "like_nested"
    end

    it "should have the default settings" do
      @config.foo.should == "bar"
    end

    it "should have settings it's file" do
      @config.new_config.should == "yes_i_am"
    end

    it "should have settings from config referenced by 'profigure_like'" do
      @config.marco.should == "polo"
    end

    it "should override configs from refrerenced with actual file" do
      @config.top_level.second_level.third_level.bar.should == "foo"
    end

  end
end
