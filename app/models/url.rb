class Url < ActiveRecord::Base
  attr_accessible :original_url, :short_url
  validates :original_url, :presence => true
  validates :original_url, :format => URI::regexp(%w(http https))

  before_create :shorten_url

  def self.redirect_to_original short
    url = self.find_by_short_url short
    url.original_url if url.present?
  end

  private

  def shorten_url
    self.short_url = SecureRandom.urlsafe_base64(5)
  end
end
