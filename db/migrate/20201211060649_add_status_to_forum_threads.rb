class AddStatusToForumThreads < ActiveRecord::Migration[6.0]
  def up
    add_column :forum_threads, :status, :boolean, :default => false
  	end
  	

  def down
  	remove_column :forum_threads, :status
  end
end
