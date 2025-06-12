class ResponsePolicy < AdminPolicy
  def create?
    if @record.observation?
      @user.admin? || @user.observer?
    elsif @record.fidelity? || @record.demographics?
      @user.admin? || @user.facilitator? || @user.observer?
    else
      @user.admin?
    end
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def edit?
    update?
  end

  def destroy?
    @user.admin? || @record.user == @user
  end
end
