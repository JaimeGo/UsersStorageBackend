module Api
  module V1
    class UsersController < ApplicationController

      before_action :set_user, only: [:show, :update, :destroy]

      def new
        @user=User.new
      end

      def create
        @user=User.new(user_params)

        if @user.save

          # We could send the base 64 representation of the data, but url is enough
          #@base64=Base64.strict_encode64(@user.avatar.download)

          avatar_data={:avatar_location => url_for(@user.avatar)}

          render json: @user.attributes.merge(avatar_data), status: :created

        else

          render json: @user.errors, status: :unprocessable_entity

        end
      end

      def update
        if @user.update(user_params)

          render json: @user

        else

          render json: @user.errors, status: :unprocessable_entity

        end
      end

      def edit

      end

      def destroy
        @user.destroy
      end

      def index
        @users=User.all

        users_with_avatar = @users.map do |user|

          avatar_data={:avatar_location => url_for(user.avatar)}
          user.attributes.merge(avatar_data)

        end

        render json: users_with_avatar

      end

      def show

        avatar_data={:avatar_location => url_for(@user.avatar)}
        render json: @user.attributes.merge(avatar_data)

      end



      def set_user
        @user=User.find(params[:id])
      end

      def user_params
        params.permit(:name, :last_name, :rut, :avatar)
      end
    end

  end
end



