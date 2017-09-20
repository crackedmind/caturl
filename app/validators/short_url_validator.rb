class ShortUrlValidator
  include ActiveModel::Validations

  delegate :url, to: :record
  
  validates_presence_of :url
  validates_format_of :url, with: /(http[s]?):\/\/.+/i, message: 'is invalid, missing http or https.'

  attr_reader :record

  def initialize(record)
    @record = record
  end
end