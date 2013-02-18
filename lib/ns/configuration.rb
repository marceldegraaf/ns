module Ns
  class Configuration
    attr_accessor :username, :password

    def initialize
      @username = nil
      @password = nil
    end

    def username
      @username || ''
    end

    def password
      @password || ''
    end

  end
end
