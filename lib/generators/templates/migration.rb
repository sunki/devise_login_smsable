class AddDeviseLiginSmsableTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    <%- phone_column = DeviseLoginSmsable::Main.config.phone_column_name -%>
    <%- if !respond_to? phone_column %>
    add_column :<%= table_name %>, :<%= phone_column %>, :string
    <%- end -%>
    add_column :<%= table_name %>, :sms_code, :string
    add_column :<%= table_name %>, :sms_code_valid, :boolean, :default => false
    add_column :<%= table_name %>, :sms_code_expire, :datetime
  end

  def self.down
    # Add :phone column manually if it did not exist before this migration was upped
    
    remove_column :<%= table_name %>, :sms_code
    remove_column :<%= table_name %>, :sms_code_valid
    remove_column :<%= table_name %>, :sms_code_expire
  end
end
