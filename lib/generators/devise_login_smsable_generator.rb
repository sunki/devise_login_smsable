require 'rails/generators/active_record'

class DeviseLoginSmsable::MigrationGenerator < ActiveRecord::Generators::Base
  namespace "devise_login_smsable"
  source_root File.expand_path("../templates", __FILE__)

  def copy_login_smsable_migration
    migration_template "migration.rb", "db/migrate/add_devise_login_smsable_to_#{table_name}"
  end
  
end
