class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters , if: :devise_controller?

    protected

        #ログイン後のリダイレクト先
        def after_sign_in_path_for(resource)
            case resource
            when current_customer
                customers_path(resource)
            when current_admin
                admin_root_path
            end
        end

        #ログアウト後のリダイレクト先
        def after_sign_out_path_for(resource)
            # case resource
            # when :customer
            #     new_customer_session_path
            # when :admin
            #     new_admin_session_path
            # end
            if resource == :admin
                new_admin_session_path
            else
                new_customer_session_path
            end
        end


        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up,
            keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number])
            devise_parameter_sanitizer.permit(:account_update,
            keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number])
        end
end
