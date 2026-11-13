class OnboardingsController < ApplicationController
  layout "wizard"

  before_action :set_user
  before_action :load_invitation
  before_action :apply_saved_onboarding_locale

  def show
  end

  def preferences
  end

  def trial
  end

  private
    def set_user
      @user = Current.user
    end

    def load_invitation
      @invitation = Current.family.invitations.accepted.find_by(email: Current.user.email)
    end

    def apply_saved_onboarding_locale
      return if params[:locale].present?
      return unless @user&.set_onboarding_preferences_at?

      locale = @user.family.locale
      return if locale.blank?

      locale = locale.to_sym
      I18n.locale = locale if I18n.available_locales.include?(locale)
    end
end
