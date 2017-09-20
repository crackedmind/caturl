class BaseService
  private
    def error(message, http_status = nil)
      @result = {
        message: message,
        status: :error
      }
  
      @result[:http_status] = http_status if http_status
      @result
    end
  
    def success()
      result[:status] = :success
      result
    end
  
end