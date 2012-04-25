module YmDocs::HasPdf
  def has_pdf
    class_eval do
      file_accessor :file
      validates_property :format, :of => :file, :in => [:pdf], :message => "must be a pdf", :allow_blank => true
      validates :file, :length => {:maximum => 10.megabytes}, :allow_blank => true
      before_save :extract_text_from_pdf
      send(:include, InstanceMethods)
    end
  end
  
  module InstanceMethods

    def file_path
      file.try(:file).try(:path)
    end
    
    def set_file_intro
      return true if !changed.include?("file_uid")
      self.file_intro = extract_text_from_pdf(1000000)
    end
    
    private
    def extract_text_from_pdf(num_chars)
      text_path = "#{file_path}-text#{rand(1000)}.txt"
      if system("pdftotext -enc UTF-8 #{file_path} #{text_path} 2>&1") && File.exists?(text_path)
        File.new(text_path).read(num_chars)
      end
    end
  
  
  end

end
