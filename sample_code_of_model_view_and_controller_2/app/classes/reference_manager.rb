module SampleCode
  class ReferenceManager
    attr_accessor :current_user, :reference
    def initialize(user, params={})
      @current_user, self.reference = user, params
    end
    def company
      @current_user.company
    end
    def references
      company.references
    end
    def reference=(params)
      @reference = references.build(params)
    end
    def reference
      @reference ||= references.build
    end
    def new_total
      (_=total) < 4 && _ || _ + 1 
    end
    delegate :save, to: :reference
    delegate :total_references, to: :company
    delegate :find, :count, :each, :reject, :received, :each_with_index, to: :references
    alias_method :total, :total_references
  end
end
