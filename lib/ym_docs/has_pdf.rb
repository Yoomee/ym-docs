module YmDocs::HasPdf
  def has_pdf
    class_eval do
      file_accessor :file
      image_accessor :image
      validates_property :format, :of => :file, :in => [:pdf], :message => "must be a pdf", :allow_blank => true
      validates :file, :length => {:maximum => 10.megabytes}, :allow_blank => true
      before_save :set_file_intro
      after_validation :generate_file_image
      send(:include, InstanceMethods)
    end
  end
  
  module InstanceMethods

    def file_path
      file.try(:file).try(:path)
    end
    
    private  
    def set_file_intro
      return true if !changed.include?("file_uid")
      self.file_intro = extract_text_from_pdf(1000000)
    end
    
    def extract_text_from_pdf(num_chars)
      text_path = "#{file_path}-text#{rand(1000)}.txt"
      if system("pdftotext -enc UTF-8 #{file_path} #{text_path} 2>&1") && File.exists?(text_path)
        File.new(text_path).read(num_chars)
      end
    end
  
    def generate_file_image
      return true if errors.present? || !changed.include?("file_uid")
      preview_path = "#{file_path}-preview#{rand(1000)}.png"
      system("convert #{file_path}[0] #{preview_path}")
      self.image = File.new(preview_path)
    end
  
  end

end
