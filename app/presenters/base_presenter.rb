class BasePresenter
  def initialize(model, template)
    @model = model
    @template = template
  end

  def h
    @template
  end

  def self.presents(name)
    define_method(name) do
      @model
    end
  end
end
