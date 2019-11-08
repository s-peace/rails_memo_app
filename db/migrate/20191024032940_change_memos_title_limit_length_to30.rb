class ChangeMemosTitleLimitLengthTo30 < ActiveRecord::Migration[5.2]
  def up
    change_column :memos, :title, :string, limit:30
  end

  def down
    change_column :memos, :title, :string
  end
end
