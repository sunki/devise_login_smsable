class LoginSmsableController < ActionController::Base

  layout 'application'

  before_filter do
    raise DeviseLoginSmsable::UnknownModel if !DeviseLoginSmsable::Main.models.include? params[:id]

    send "authenticate_#{params[:id]}!"
    @user = send "current_#{params[:id]}"
  end

  def edit
  end

  def update
    if @user.sms_code == params[:login_smsable][:sms_code]
      @user.sms_code_valid = true
      @user.save!

      redirect_to after_sign_in_path_for @user
    else
      flash[:notice] = 'sms_code_invalid_or_expired'
      render :edit
    end
  end

end
