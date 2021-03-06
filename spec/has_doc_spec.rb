require 'spec_helper'

describe YmDocs::HasDoc do
  
  describe "has_doc" do

    it "includes YmDocs::HasDoc::InstanceMethods module" do
      Resource.included_modules.should include(YmDocs::HasDoc::InstanceMethods)
    end
  
  end
  
  describe 'extract_text_from_pdf' do
    
    let(:resource) {FactoryGirl.build(:resource)}
    
    it 'returns first 10 characters from file' do
      resource.stub(:temp_file_path => File.expand_path('../test/assets/test.pdf', File.dirname(__FILE__)))
      resource.send(:extract_text_from_pdf, 10).should == "Class apte"
    end
    
    after do
      test_assets_path = File.expand_path('../test/assets', File.dirname(__FILE__))
      system("rm #{test_assets_path}/test.pdf-text*")
    end
    
  end
  
end