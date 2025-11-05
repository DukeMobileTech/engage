class UserPolicy < AdminPolicy
  def invite?
    update?
  end

  def profile?
    @user.id == @record.id || @user.admin?
  end
end
