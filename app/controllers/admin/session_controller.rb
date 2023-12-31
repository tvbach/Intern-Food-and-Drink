class Admin::SessionController < Admin::AdminController
    skip_before_action :check_admin_login, only: [:create]
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password]) && user.admin?
            session[:user_id] = user.id
            redirect_to(admin_home_path)
        else
            flash[:error] = "Invalid email or password"
            redirect_to(admin_root_path)
        end
    end

    def destroy
        admin_log_out if admin_logged_in?
        redirect_to(admin_root_path)
    end
end
