class SectionPolicy < AdminPolicy
  def data_tracker?
    create?
  end
end
