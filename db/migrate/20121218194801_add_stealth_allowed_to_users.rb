class AddStealthAllowedToUsers < ActiveRecord::Migration

  # Rails 3
  def up
    unless column_exists? :users, :stealth_allowed
      add_column :users, :stealth_allowed, :boolean, :default => false
    end
  end

  def down
    if column_exists? :users, :stealth_allowed
      remove_column :users, :stealth_allowed
    end
  end

  class << self

    # Rails 2
    def up
      add_column :users, :stealth_allowed, :boolean, :default => false
    end

    def down
      remove_column :users, :stealth_allowed
    end

  end
end
