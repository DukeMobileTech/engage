class SectionPolicy < AdminPolicy
  def data_tracker?
    create?
  end

  def update?
    @user.admin? || @user.facilitator? || @user.observer?
  end

  def edit?
    update?
  end

  def fidelity_logs?
    show?
  end
end
