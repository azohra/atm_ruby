module TMJ
  class BaseError < StandardError
    extend Forwardable

    def_instance_delegators :@response, :code
    attr_reader :response

    def raise_401
      'Authentication error. Username or password is incorect'
    end
  end
end
