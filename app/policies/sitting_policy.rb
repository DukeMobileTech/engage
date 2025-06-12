class SittingPolicy < AdminPolicy
  def create?
    @user.admin? || @user.facilitator? || @user.observer?
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

  def bulk?
    create?
  end

  def bulk_create?
    create?
  end

  def destroy?
    @user.admin? || @record.users.include?(@user)
  end
end
