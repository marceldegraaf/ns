module Ns
  class Configuration
    attr_accessor :username, :password

    def username
      @username || ''
    end

    def password
      @password || ''
    end

  end
end
