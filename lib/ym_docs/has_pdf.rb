module YmDocs::HasPdf
  
  require 'kconv'
  
  def has_pdf
    class_eval do
      file_accessor :file
      image_accessor :image
      validates_property :format, :of => :file, :in => [:pdf], :message => "must be a pdf", :allow_blank => true
      validates :file, :length => {:maximum => 10.megabytes}, :allow_blank => true
      before_save :set_file_text_and_summary
      after_validation :generate_file_image
      send(:include, InstanceMethods)
    end
  end
  
  module InstanceMethods

    def file_ext
      file.try(:ext)
    end

    def file_path
      file.try(:path)
    end
    
    private  
    def set_file_text_and_summary
      return true if !changed.include?("file_uid")
      self.file_text = extract_text_from_pdf(1000000)
      unless summary.present?
        self.summary = file_text.first(200)
      end
    end
    
    def extract_text_from_pdf(num_chars)
      temp_path = "#{temp_file_path}-text#{rand(1000)}.txt"
      if system("pdftotext -enc UTF-8 #{temp_file_path} #{temp_path} 2>&1") && File.exists?(temp_path)
        File.new(temp_path).read(num_chars).toutf8
      end
    end
  
    def generate_file_image
      return true if errors.present? || !changed.include?("file_uid")  
      temp_path = "#{temp_file_path}-preview#{rand(1000)}.png"
      system("convert #{temp_file_path}[0] #{temp_path}")
      self.image = File.new(temp_path)
    end

    def temp_file_path
      file.try(:file).try(:path)
    end
  
  end

end
