require 'lib/richfile'
require "md5"

describe OpenSSL, "version" do
  subject { OpenSSL::OPENSSL_VERSION_NUMBER }
  it "should be greater than 0x00908000" do
    subject.should be > 0x00908000
  end
end

describe Richfile::Base do
  subject { File.new(File.join(File.dirname(__FILE__), "SimpleDigestTest.txt")) }
  
  it "should exist" do
    subject.exists?.should == true
  end
  
  it "should provide a size attribute" do
    subject.should respond_to(:size)
    subject.size.should be > 0
    subject.size.should == File.size(subject)
  end
  it "should provide a mtime attribute" do
    subject.should respond_to(:mtime)
    subject.mtime.should be < Time.new
    subject.mtime.should == File.mtime(subject)
  end
  it "should provide a ctime attribute" do
    subject.should respond_to(:ctime)
    subject.ctime.should be < Time.new
    subject.ctime.should be <= subject.mtime
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

{ #:dss => nil, - unsupported
  :dss1 => "dee5ba176cb2d1cc7d9a5fc3a2240a37645d6b46",
  :md2 => "8c13cca992d071c02fd338b6c13ab71b",
  :md4 => "3575477e0da66828dcbba890b728d855",
  :md5 => "927f712a74d0cf1281f93874499986c2",
  #:mdc2 => nil, - unsupported
  :ripemd160 => "e9b5c5c6e110022f0a5b493ed1b267c6face4c17",
  :sha => "26f42cf9c6cfe3d95ab924d3b89b210a526a1ea1",
  :sha1 => "dee5ba176cb2d1cc7d9a5fc3a2240a37645d6b46", 
  :sha224 => "e69ec20e01d6fac380b727b872dc0e14d1f255d40c3614e075d87de5",
  :sha256 => "204e57f6dc0d8787f87e04347666129a2bd7deddf8949c735a78380b7c2ac65d",
  :sha384 => "a2544e5c3b1a04b38ff0cf8cc29b81bd0fc08d12975949210123e51ae3af1da1538bf3fa6e1b73fc198bc0ac289f891f",
  :sha512 => "137a67bfe730049222f7ac4969d14c3c79ee82d90bd1e223a0217abd8a73f617036222dce542d6243a7b94bc76ff1ee1359f073bb6a116df07c76c2164927800"
  }.each do |cypher, checksum|
  describe Richfile, ".#{cypher} message digest/checksum" do
    subject { File.new(File.join(File.dirname(__FILE__), "SimpleDigestTest.txt")) }
    it "should provide a #{cypher} attribute" do
      subject.should respond_to(cypher)
      subject.send(cypher).should == checksum
    end
    it "should provide a #{cypher}! method" do
      subject.should respond_to("#{cypher}!".to_sym)
      subject.send("#{cypher}!".to_sym).should == checksum
    end
  end
end


describe Richfile::Base do
  subject { Richfile }
  it "should have a DIGESTS constant with all digests" do
    Richfile::DIGESTS.should == %w(DSS1 MD2 MD4 MD5 RIPEMD160 SHA SHA1 SHA224 SHA256 SHA384 SHA512)
  end
end

describe Richfile::Base, "refresh!" do
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

describe Richfile::Base, "refresh_all!" do
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
