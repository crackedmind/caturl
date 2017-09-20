class CreateShortUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :short_urls do |t|
      t.string :url
      t.string :short_url
      t.integer :clicks, default: 0
      t.timestamps
    end

    add_index :short_urls, :short_url, unique: true
  end
end
