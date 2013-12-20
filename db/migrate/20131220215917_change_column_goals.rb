class ChangeColumnGoals < ActiveRecord::Migration
  def up
    rename_column :goals, :private, :is_private
  end

end
