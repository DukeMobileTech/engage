class UserPolicy < AdminPolicy
  def invite?
    update?
  end
end
