# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    return unless user.present?
    can :create, Post
    can :create, Comment
    can :create, Like
    can :destroy, Post, author_id: user.id
    can :destroy, Comment, author_id: user.id
    can :destroy, Like, author_id: user.id 
    return unless user.admin?
    can :manage, all
  end
end
