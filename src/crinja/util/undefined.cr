module Crinja
  # The default undefined type.
  class Undefined
    INSTANCE = new

    getter name

    def initialize(@name = "")
    end

    def to_s(io)
    end
  end

  # An undefined that raises an `UndefinedError` if it is compared or printed.
  class StrictUndefined < Undefined
    INSTANCE = new

    def ==(other)
      fail
    end

    def <=>(other)
      fail
    end

    def to_s(io)
      fail
    end

    private def fail
      raise UndefinedError.new(self.name)
    end
  end
end
