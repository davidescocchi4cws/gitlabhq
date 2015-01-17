class ApplicationSetting < ActiveRecord::Base
  validates :home_page_url, allow_blank: true,
    format: { with: URI::regexp(%w(http https)), message: "should be a valid url" }

  def self.current
    ApplicationSetting.last
  end

  def self.create_from_defaults
    create(
      default_projects_limit: Settings.gitlab['default_projects_limit'],
      signup_enabled: Settings.gitlab['signup_enabled'],
      signin_enabled: Settings.gitlab['signin_enabled'],
      gravatar_enabled: Settings.gravatar['enabled'],
      sign_in_text: Settings.extra['sign_in_text'],
    )
  end
end
