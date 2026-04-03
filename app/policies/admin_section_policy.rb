class AdminSectionPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def index?
    user.admin?
  end
end
