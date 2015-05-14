class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #

    if user.nil?
      can :read, :all
    elsif user.admin?
      can :manage, :all
    else
      can :create, Topic
      can :create, Reply
      can :create, Cliq
      can :update, Topic do |topic|
        topic.try(:user) == user || check_if_mod_for_topic(user,topic)
      end
      can :update, Reply do |reply|
        reply.try(:user) == user || check_if_mod_for_reply(user,reply)
      end
    end
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

    private

    def check_if_mod_for_topic(user,topic)
      user.roles.any? {|role| role.name == 'mod' && Cliq.find(role.cliq_id).id == topic.cliq.id}
    end

    def check_if_mod_for_reply(user,reply)
      user.roles.any? {|role| role.name == 'mod' && Cliq.find(role.cliq_id).id == reply.topic.cliq.id}
    end


end
