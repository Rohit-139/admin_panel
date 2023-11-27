ActiveAdmin.register Instructor do
  menu parent: 'users', priority: 1
  permit_params :name, :email, :password, :type, :country_name, :state, :city, :dob

  # permit_params do
  #   permitted = [:name, :email, :password, :user_type, :country_name, :state, :city, :dob]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  actions :all, except: [:new]

  index do
    id_column
    column :name
    column :email
    column :type
    column :country_name
    column 'Category' do |obj|
      obj.category.name
    end
    column :dob
    # add column name for actions
    actions name: "Actions"
  end

  show do
    attributes_table do
      row :name
      row :email
      row 'Country', &:country_name
      row 'Date of birth', &:dob
      row 'Category' do |obj|
        obj.category.name
      end
      row :state
      row :city
      row :type
    end
  end

  form do |f|
    f.input :type, label: 'Role', as: :select, collection: ["Instructor", 'Customer'], input_html: { disabled: true },as: :string unless f.object.new_record?
    f.input :type, label: 'Role', as: :select, collection: ["Instructor", 'Customer'] if f.object.new_record?
    f.input :name
    f.input :email
    f.input :password if f.object.new_record?
    # make country non-editable, default value india and label country
    f.input :country_name, :label => 'Country', input_html: { disabled: true }, as: :string unless f.object.new_record?
    f.input :country_name, :label => 'Country', as: :string if f.object.new_record?

    f.input :dob, :label => 'DOB', as: :datetimepicker, datetimepicker_options: { format: "%dd-%mm-%yyyy"}
    f.input :state, :as => :select, :collection => ['Madhya Pradesh', 'Uttarakhand', 'Himachal Pradesh'], :label => 'State'
    f.input :city
    f.actions
  end

end
