class Ability
  include CanCan::Ability

  def initialize(user)
    # permissions = []
    # user.roles.each do |role|
    #     role.permissions.each do |per|
    #         permissions << per
    #     end
    # end
    # user.permissions.each do |per|
    #     permissions << per
    # end

    permissions = user.role_permissions + user.permissions
    if permissions.present?
      permissions = permissions.uniq
      permissions.each do |permission|
        if permission.subject_class == "all"
          can permission.action.to_sym, permission.subject_class.to_sym
        else
          can permission.action.to_sym, get_permission(permission.subject_class)
        end
      end
    end
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end

  def get_permission(controller)
    return name = controller.sub('Controller','').singularize.split('::').last.constantize rescue nil
  end
end
