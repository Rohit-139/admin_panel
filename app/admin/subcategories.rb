ActiveAdmin.register Subcategory do

  menu parent: 'Category_Sub_Category'
  permit_params :category_id, :name

  index do
    id_column
    column :name
    column 'Parent' do |obj|
      obj.category.name
    end
    actions name:   'Actions'
  end
  
end
