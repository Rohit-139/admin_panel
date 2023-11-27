ActiveAdmin.register User do

  permit_params :name, :email, :password, :type, :country_name, :state, :city, :dob

  menu priority: 1

  # disabling action "new"
  actions :all, except: [:new]

  collection_action :export_csv_xl_format, method: :get
  action_item :only => :index do
    link_to 'Export Csv', export_csv_xl_format_admin_users_path(format: :xlsx), method: :get
  end

  index download_links: false do
    id_column
    column :name
    column :email
    column :type
    column :country_name
    column :dob
    # add column name for actions
    actions name: "Actions"
  end

  show do
    attributes_table do
      row :name
      row :email
      row 'Country', &:country_name
      row :dob
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

  controller do
    def create
      @user = User.new(permitted_params[:user])
      if @user.save
        redirect_to admin_users_url
      end
    end

    def export_csv_xl_format
      @users = User.all
      respond_to do |format|
        format.xlsx {
          render xlsx: 'admin/export_csv_xl_format',
          filename: 'user.xlsx'
        }
      end
    end
  end
end
