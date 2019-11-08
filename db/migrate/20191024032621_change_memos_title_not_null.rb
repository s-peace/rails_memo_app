class ChangeMemosTitleNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :memos, :title, false
  end
end
