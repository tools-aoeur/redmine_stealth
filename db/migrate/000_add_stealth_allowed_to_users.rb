class AddStealthAllowedToUsers < ActiveRecord::Migration

  # Rails 3
  def up
    self.class.add_stealth_allowed
  end

  def down
    self.class.remove_stealth_allowed
  end

  class << self

    # Rails 2
    def up
      add_stealth_allowed
    end

    def down
      remove_stealth_allowed
    end

    def add_stealth_allowed
      add_column :users, :stealth_allowed, :boolean, :default => false 
    end

    def remove_stealth_allowed
      remove_column :users, :stealth_allowed
    end
  end
end
