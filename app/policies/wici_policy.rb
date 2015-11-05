class WiciPolicy < ApplicationPolicy

  def show? 
    record.public? || user.present?
  end

  def make_private?
    user.admin? || user.premium?
  end

  class Scope < User
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      #wicis = []
      if user.admin?
        wicis = scope.all
      elsif user.premium?
        scope.where("private = ? OR user_id = ?", false, user.id)
        #all_wicis = scope.all
        #all_wicis.each do |w|
          #if !(w.private?) || w.user == user
           # wicis << w
          #end
        #end
      else
        scope.where(private: false)
      #  all_wicis = scope.all?
      #  all_wicis.each do |w|
      #    if !(w.private?)
      #      wicis << w
      #    end
      #  end
      end
      #wicis
    end
  end




end
