# encoding: utf-8

class ApplicationController < ActionController::Base
  before_action :calc_notification_count
  # for error handling
  rescue_from ActiveRecord::RecordNotFound, with: :handle_404

  def handle_404(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  rescue_from Exception, with: :error500
  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404

  private

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

  def authenticate
    return if logged_in?
    redirect_to root_path, alert: 'ログインしてください'
  end

  def calc_notification_count
    if logged_in?
      @notification_count = current_user.notifications.where(read: false).count
    end
  end

  def error404(e)
    render 'error404', status: 404, formats: [:html]
  end

  def error500(e)
    logger.error [e, *e.backtrace].join("\n")
    render 'error500', status: 500, formats: [:html]
  end
end
