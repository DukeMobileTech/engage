class SectionPolicy < AdminPolicy
  def data_tracker?
    create?
  end

  def update?
    @user.admin? || @user.facilitator?
  end

  def edit?
    update? || @user.facilitator?
  end
end
