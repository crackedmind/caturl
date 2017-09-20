class AddIndexToShortUrl < ActiveRecord::Migration[5.1]
  def change
    add_index :short_urls, :url, unique: true
  end
end
