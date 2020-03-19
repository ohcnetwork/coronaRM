class AddHealthDepartmentInformationToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :health_institution, :string
    add_column :contacts, :field_staff_name, :string
    add_column :contacts, :field_staff_phone, :string
  end
end
