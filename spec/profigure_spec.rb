require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Profigure" do
  before do
    @config_dir = File.join(File.dirname(__FILE__), "test_config")
  end

  it "loads from defaults" do
    config = Profig.load @config_dir

    config.foo.should == "bar"
  end

  it "also loads from your environment" do
    config = Profig.load @config_dir, "test"

    config.another.should == "example"
  end

  it "should override defaults with keys in env file" do
    config = Profig.load @config_dir, "overrides"

    config.foo.should == "overridden"
  end

  it "should properly handle nested hashes" do
    config = Profig.load @config_dir, "nested"

    config.top_level.second_level.third_level.bar.should == "baz"
  end

  it "should properly handle arrays" do
    config = Profig.load @config_dir, "arrays"

    config.array.size.should == 2
    config.array[1].should == "two"
  end

  it "should allow overriding after load" do
    config = Profig.load @config_dir, "test"
    config.foo = "bar"

    config.foo.should == "bar"
  end

  it "should allow reading via hash notation" do
    config = Profig.load @config_dir, "test"

    config[:foo].should == "bar"
  end
end
