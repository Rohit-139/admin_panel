ActiveAdmin.register Category do

  menu parent: 'Category_Sub_Category'

  permit_params :name, :image

  index do
    # byebug
    id_column
    column 'Image' do |obj|
      image_tag (obj&.image), width: 50, height: 50 rescue nil
    end
    column :name
    # column 'View Count'
    actions name:   'Actions'
  end

  show do
    attributes_table do
      row :name
      row 'Image' do |obj|
        image_tag (obj&.image), width: 50, height: 50 rescue nil
      end
      panel "Sub Categories" do
        table_for category.subcategories do
          column :name
        end
      end
    end
  end

  form do |f|
    f.input :name
    f.input :image, as: :file
    f.actions
  end

  before_action do
      ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

end
