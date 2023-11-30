class AddStealthAllowedToUsers < ActiveRecord::Migration[4.2]
  def up
    return if column_exists? :users, :stealth_allowed

    add_column :users, :stealth_allowed, :boolean, default: false
  end

  def down
    return unless column_exists? :users, :stealth_allowed

    remove_column :users, :stealth_allowed
  end
end
