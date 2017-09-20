class ShortUrl < ApplicationRecord
  include Rails.application.routes.url_helpers

  def short_url
    short_url_url(id: attributes['short_url'])
  end

  def short
    attributes['short_url']
  end

  def as_json(*)
    super(only: [:url], methods: [:short_url, :short])
  end
end
