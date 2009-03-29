require 'lib/richfile'
require 'md5'

describe OpenSSL, "version" do
  subject { OpenSSL::OPENSSL_VERSION_NUMBER }
  it "should be greater than 0x00908000" do
    subject.should be > 0x00908000
  end
end

describe Richfile::Base, "example SimpleDigestTest.txt" do
  subject { File.new(File.join(File.dirname(__FILE__), "SimpleDigestTest.txt")) }
  
  it "should exist" do
    subject.exists?.should == true
  end
  
  it "should have a size attribute" do
    subject.should respond_to(:size)
    subject.size.should be > 0
    subject.size.should == File.size(subject)
  end
  it "should have a mtime attribute" do
    subject.should respond_to(:mtime)
    subject.mtime.should == File.mtime(subject)
  end
  it "should have a ctime attribute" do
    subject.should respond_to(:ctime)
    subject.ctime.should == File.ctime(subject)
  end
  
  it "should yield the same result as the built-in MD5 function" do
    d = MD5.new
    File.open(File.join(File.dirname(__FILE__), "SimpleDigestTest.txt")) do |f|
      d << f.read
    end
    d.hexdigest.should == subject.md5!
  end
end

describe Richfile::Base, ".refresh!" do
  subject { File.new(File.join(File.dirname(__FILE__), "SimpleDigestTest.txt")) }
  
  it "should refresh the file size if the size was used" do
    subject.size
    subject.should_receive(:size!).once
    subject.refresh!
  end
  it "should not refresh the file size if the size was not used" do
    subject.should_not_receive(:size!)
    subject.refresh!
  end

  it "should refresh the MD5 digest if the MD5 digest was used" do
    subject.md5
    subject.should_receive(:md5!).once
    subject.refresh!
  end
  it "should not refresh the MD5 digest if the MD5 digest was not used" do
    subject.should_not_receive(:md5!)
    subject.refresh!
  end

  it "should refresh the SHA1 digest if the SHA1 digest was used" do
    subject.sha1
    subject.should_receive(:sha1!).once
    subject.refresh!
  end
  it "should not refresh the SHA1 digest if the SHA1 digest was not used" do
    subject.should_not_receive(:sha1!)
    subject.refresh!
  end

  it "should refresh the SHA512 digest if the SHA512 digest was used" do
    subject.sha512
    subject.should_receive(:sha512!).once
    subject.refresh!
  end
  it "should not refresh the SHA512 digest if the SHA512 digest was not used" do
    subject.should_not_receive(:sha512!)
    subject.refresh!
  end
end

describe Richfile::Base, ".refresh_all!" do
  subject { File.new(File.join(File.dirname(__FILE__), "SimpleDigestTest.txt")) }
  
  it "should refresh the file size" do
    subject.should_receive(:size!).once
    subject.refresh_all!
  end

  it "should refresh the MD5 digest" do
    subject.should_receive(:md5!).once
    subject.refresh_all!
  end

  it "should refresh the SHA1 digest" do
    subject.should_receive(:sha1!).once
    subject.refresh_all!
  end

  it "should refresh the SHA512 digest" do
    subject.should_receive(:sha512!).once
    subject.refresh_all!
  end
end
