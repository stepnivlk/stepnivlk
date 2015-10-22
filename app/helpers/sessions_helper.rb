module SessionsHelper

  # Writes encrypted id of given user to session.
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if some user is logged.
  def logged_in?
    !current_user.nil?
  end

  # Returns true if logged in user is admin.
  def logged_in_admin?
    logged_in? && current_user.admin
  end

  # Deletes remember_digest from user model.
  # Deletes given user and his remember token from cookies.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # logs out current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns model objects based on current user rights with optional pagination.
  #
  # model    - Right model, has to have user_id and public fields.
  # paginate - If set, use pagination. Default = true.
  # per_page - No. of objects per page. Default = 10.
  def scoped_index(model, paginate = true, per_page = 25)
    if logged_in? 
      @contents = model.where(:user_id == current_user.id).order("created_at DESC")
    elsif logged_in_admin?
      @contents = model.order("created_at DESC")
    else
      @contents = model.where(public: true).order("created_at DESC")
    end
    return @contents unless paginate
    @contents = @contents.paginate(page: params[:page], per_page: per_page)
  end

  # Redirects to URL from session or to given URL.
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def delete_location
    session.delete(:forwarding_url) if session.delete(:forwarding_url)
  end
end
