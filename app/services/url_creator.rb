class UrlCreator
  attr_reader :original_url

  def initialize(original_url)
    @original_url = original_url
  end

  def call
    short_url = UrlGenerator.()
    url = ShortUrl.new(url: original_url, short_url: short_url)
    v = ShortUrlValidator.new(url)

    if v.valid?
      if url.save
        {
          result: true,
          data: url,
          http_code: :created
        }
      end
    else
      {
        result: false,
        data: {error_messages: v.errors.full_messages},
        http_code: :not_acceptable
      }
    end
  end
end