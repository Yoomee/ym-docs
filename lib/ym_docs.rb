require "ym_docs/engine"

module YmDocs
end

require 'ym_docs/has_pdf'
ActiveRecord::Base.extend YmDocs::HasPdf