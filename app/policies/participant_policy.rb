class ParticipantPolicy < AdminPolicy
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

  def enroll?
    update?
  end

  def bulk?
    create?
  end

  def bulk_create?
    create?
  end

  def merge?
    @user.admin?
  end

  def meld?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  def autocomplete?
    create?
  end
end
