class AddSoundcloudUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :soundcloud_url, :string
  end
end
