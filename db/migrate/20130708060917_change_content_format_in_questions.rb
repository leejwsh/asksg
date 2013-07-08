class ChangeContentFormatInQuestions < ActiveRecord::Migration
  def up
    change_column :questions, :content, :text, :limit => nil
  end

  def down
    change_column :questions, :content, :string
  end
end
