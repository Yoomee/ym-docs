require 'ym_core'

require "ym_docs/engine"

module YmDocs
end

require 'ym_docs/has_doc'
ActiveRecord::Base.extend YmDocs::HasDoc