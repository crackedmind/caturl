class UrlCreator
  attr_reader :original_url

  def initialize(original_url)
    @original_url = original_url
  end

  def call
    result = { }
    begin
      url = ShortUrl.where(url: original_url).first
      unless url
        short_url = UrlGenerator.()
        url = ShortUrl.new(url: original_url, short_url: short_url)
        v = ShortUrlValidator.new(url)

        if v.valid? && url.save
          make_result(true, url, :created)
        else
          make_result(false, {error_messages: v.errors.full_messages}, :not_acceptable)
        end
      else
        make_result(true, url, :created)
      end

    end
  rescue ActiveRecord::RecordNotUnique => not_unique
    retry
  end

  def make_result(result, data, http_code)
    {
      result: result,
      data: data,
      http_code: http_code
    }
  end
end