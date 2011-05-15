# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NilClass do
  describe "escaping to an SSSI" do
    it "should escape nil" do
      nil.to_sssi.should be_nil
    end
  end
end

describe String do
  describe "escaping to an SSSI" do
    it "should escape $" do
      'Ke$ha'.to_sssi.should == 'Ke\$ha'
    end
    
    it "should escape double quotes" do
      'foo "bar"'.to_sssi.should == 'foo \"bar\"'
    end
    
    it "should convert weird quotes to single quotes" do
      'foo ‘bar’'.to_sssi.should == "foo 'bar'"
    end
  end
end

describe Hash do
  describe "converting to an SSSI" do
    it "should work with an empty hash" do
      {}.to_sssi.should == ''
    end
    
    it "should work with a hash" do
      { 'foo' => 'bar' }.to_sssi.should == '<!--#set var="foo" value="bar" -->'
    end
    
    it "should work with a hash that has a number value" do
      { 'foo' => 1 }.to_sssi.should == '<!--#set var="foo" value="1" -->'
    end
    
    it "should work with a hash that has a boolean value" do
      { 'foo' => true }.to_sssi.should == '<!--#set var="foo" value="1" -->'
      { 'foo' => false }.to_sssi.should == '<!--#set var="foo" value="0" -->'
    end
  end
end

describe Array do
  describe "coverting to an SSSI" do
    it "should work with an empty array" do
      [].to_sssi.should == ''
    end
    
    it "should work with an array with a number" do
      [1].to_sssi.should == '<!--#set var="array_0" value="1" -->'
    end
    
    it "should work with a named array with a number" do
      [1].to_sssi('foo').should == '<!--#set var="foo_0" value="1" -->'
    end
    
    it "should work with an array with a bunch of stuff" do
      [1,true,'hello'].to_sssi.should == %[<!--#set var="array_0" value="1" -->\n<!--#set var="array_1" value="1" -->\n<!--#set var="array_2" value="hello" -->]
    end
    
    it "should work with an array of hashes" do
      [{:foo => 1},{:bar => 2 }].to_sssi.should == %[<!--#set var="array_0_foo" value="1" -->\n<!--#set var="array_1_bar" value="2" -->]
    end
  end
end
