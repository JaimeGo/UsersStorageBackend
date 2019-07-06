module Api
  module V1
    class UsersController < ApplicationController

      before_action :set_user, only: [:show, :update, :destroy]

      # We check if the user selected an avatar or not
      before_action :check_avatar_selected, only: [:create, :update]


      def new
        @user=User.new
      end

      def create

        @user=User.new(user_params)

        # If avatar was selected, we attach it to user
        if @avatar_selected

          @user.avatar.attach(params[:avatar])

        # If avatar was not selected, we add anonymous avatar
        else
          anon_avatar_path=File.join(Rails.root, 'public', 'anon.png' )
          @user.avatar.attach(io: File.open(anon_avatar_path), filename: 'anon.png', content_type: 'image/png')
        end

        if @user.save

          render json: @user, status: :created

        else

          render json: @user.errors, status: :unprocessable_entity

        end
      end

      def update
        if @user.update(user_params)

          if @avatar_selected

            @user.avatar.attach(params[:avatar])

          end

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

        # We send avatar url for src attribute of <img> element
        users_with_avatar = @users.map do |user|

          avatar_data={:avatar_location => url_for(user.avatar)}
          user.attributes.merge(avatar_data)

        end

        render json: users_with_avatar

      end

      def show

        # We send avatar url for src attribute of <img> element
        avatar_data={:avatar_location => url_for(@user.avatar)}
        render json: @user.attributes.merge(avatar_data)

      end



      def set_user
        @user=User.find(params[:id])
      end

      def user_params
        params.permit(:name, :last_name, :rut)
      end

      def check_avatar_selected
        @avatar_selected=params[:avatar]!="null"
      end

    end

  end
end



