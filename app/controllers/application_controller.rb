class ApplicationController < ActionController::Base
  # määritellään, että metodi current_user tulee käyttöön myös näkymissä
  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?

    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice: 'you should be signed in' if current_user.nil?
  end

  def ensure_admin
    redirect_to signin_path, notice: 'only admins can remove items from database' if !current_user.admin?
  end

  def expire_brewerylist
    expire_fragment('brewerylist')
  end
end
