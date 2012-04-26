class CreateResources < ActiveRecord::Migration
  
  def change
    create_table :resources do |t|
      t.string :name
      t.text :summary      
      t.string :file_name
      t.text :file_text     
      t.string :file_uid
      t.string :image_uid
    end
  end
  
end
