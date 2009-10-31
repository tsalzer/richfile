require File.join(File.dirname(__FILE__), 'test_helper')
#require 'md5'

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
    cypherb = "#{cypher}!".to_sym
    subject { File.new(File.join(File.dirname(__FILE__), "SimpleDigestTest.txt")) }
    
    it "should provide a #{cypher} attribute" do
      subject.should respond_to(cypher)
    end
    it "should provide a #{cypherb} method" do
      subject.should respond_to(cypherb)
    end
    it "should provide the correct value for #{cypher}" do
      subject.send(cypher).should == checksum
    end
    it "should provide the correct value for #{cypherb}" do
      subject.send(cypherb).should == checksum
    end
    it "should re-read the digests when calling #{cypherb}" do
      subject.should_receive(cypher).twice
      subject.send(cypherb)
      subject.send(cypherb)
    end
  end
end


describe Richfile::Digests, "DIGEST contant" do
  subject { Richfile::Digests }
  it "should have a DIGESTS constant with all digests" do
    subject::DIGESTS.should == %w(DSS1 MD2 MD4 MD5 RIPEMD160 SHA SHA1 SHA224 SHA256 SHA384 SHA512)
  end
end

