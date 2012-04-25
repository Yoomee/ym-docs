require 'spec_helper'

describe YmDocs::HasPdf do
  
  describe "has_pdf" do

    it "includes YmDocs::HasPdf::InstanceMethods module" do
      Resource.included_modules.should include(YmDocs::HasPdf::InstanceMethods)
    end
  
  end
  
  describe 'extract_text_from_pdf' do
    
    let(:resource) {FactoryGirl.build(:resource)}
    
    it 'returns first 10 characters from file' do
      resource.stub(:file_path => File.expand_path('../test/assets/test.pdf', File.dirname(__FILE__)))
      resource.send(:extract_text_from_pdf, 10).should == "Class apte"
    end
    
  end
  
end