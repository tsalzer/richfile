require 'lib/richfile'

digestfile_path = File.join(File.dirname(__FILE__), 'SimpleDigestTest.txt')

describe Richfile::Mimetype do
  subject do
    class Subj
      include Richfile::Mimetype
    end
    Subj.new
  end
  
  it "should use /usr/bin/file" do
    `which file`.gsub(/\n/,'').should == '/usr/bin/file'
  end
  
  it "should be kind_of Richfile::Mimetype" do
    subject.should be_a Richfile::Mimetype
  end
  
end

describe Richfile::Mimetype, ".mimetype_using_file" do
  subject { Richfile::Mimetype }
  it "should recognize SimpleDigestTest.txt as text/plain, charset=us-ascii file" do
    subject.mimetype_using_file(digestfile_path).should == ['text/plain', 'charset=us-ascii']
  end
end

describe Richfile::Mimetype::ClassMethods do
  subject do
    class Subj
      include Richfile::Mimetype::ClassMethods
    end
    Subj.new
  end
  it "should recognize SimpleDigestTest.txt as text/plain file" do
    subject.mimetype(digestfile_path).should == 'text/plain'
  end
end

describe Richfile::Mimetype::InstanceMethods do
  it "should recognize SimpleDigestTest.txt as text/plain file" do
    f = File.new(digestfile_path)
    f.should respond_to(:mimetype)
    f.mimetype.should == 'text/plain'
  end
end
