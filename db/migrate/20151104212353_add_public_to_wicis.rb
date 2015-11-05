class AddPublicToWicis < ActiveRecord::Migration
  def change
    add_column :wicis, :public, :boolean, :default => true
  end
end
