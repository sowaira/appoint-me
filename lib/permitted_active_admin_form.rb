module PermittedActiveAdminForm
  def permitted_attributes
    policy = Pundit.policy(current_business, resource)
    policy.respond_to?(:permitted_attributes) ? policy.permitted_attributes : []
  end

  def input(*args)
    super(*args) if permitted_attributes.include? args[0]
  end
end