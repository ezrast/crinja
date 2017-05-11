class Crinja::Statement
  class Name < Statement
    getter variable : Variable

    def initialize(token : Token = Token.new)
      super(token)
      @variable = Crinja::Variable.new(token.value)
    end

    def evaluate(env : Crinja::Environment) : Type
      env.resolve(variable)
    end

    def add_member(token)
      variable.add_part(token.value)
    end

    def inspect_arguments(io : IO, indent = 0)
      io << " variable="
      variable.to_s(io)
    end

    def name
      token.value
    end
  end
end