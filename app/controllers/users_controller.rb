class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]

    def index
        @q = User.ransack(params[:q])
        @pagy, @users = pagy(@q.result(distinct: true).order(created_at: :desc))

        authorize @users
    end

    def edit
        authorize @user
    end

    def show
    end

    def update
        authorize @user

        if @user.update(user_params)
            redirect_to users_path, notice: 'User roles were successfully updated.'
        else
            render :edit
        end
    end

    private

    def set_user
        @user = User.friendly.find(params[:id])
    end

    def user_params
        params.require(:user).permit({role_ids: []})
    end

end
  