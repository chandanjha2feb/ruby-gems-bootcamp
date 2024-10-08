class LessonPolicy < ApplicationPolicy
    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      def resolve
        scope.all
      end
    end

    def show?
      @user.has_role?(:admin, @user) || @record.course.user_id == @user.id || @record.course.bought(@user) == true
    end
  
    def edit?
      @user.present? && @record.course.user_id == @user.id
    end
  
    def create?
      @record.course.user_id == @user.id
    end
  
    def destroy?
        @record.course.user_id == @user.id
    end
  
    def new?
        @record.course.user_id == @user.id
    end
  
    def update?
        @record.course.user_id == @user.id
    end

    def index?
      @user.has_role?(:admin, @user)
    end
  end
  