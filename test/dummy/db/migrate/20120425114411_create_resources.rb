class CreateResources < ActiveRecord::Migration
  
  def change
    create_table :resources do |t|
      t.string :name
      t.string :file_name
      t.text :file_intro      
      t.string :file_uid
      t.string :image_uid
    end
  end
  
end
