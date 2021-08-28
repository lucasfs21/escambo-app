class Ad < ActiveRecord::Base
  # Constants
  QTT_PER_PAGE = 6

  # RatyRate gem
  ratyrate_rateable 'quality'

  # Callbacks
  before_save :markdown_to_html

  # Associations
  belongs_to :category, counter_cache: true
  belongs_to :member
  has_many :comments

  # Validates
  validates :title, :description_md, :description_short, :category, :price, :picture, :finish_date, presence:true
  validates :price, numericality: { greater_than: 0 }

  # Scopes
  scope :descending_order, ->(page) {
    order(created_at: :desc).page(page).per(QTT_PER_PAGE)
  }

  scope :ascending_order, ->(page = 1) {
    order(created_at: :asc).page(page).per(QTT_PER_PAGE)
  }

  scope :to_the, ->(member) { where(member: member) }

  scope :by_category, ->(category, page) { where(category: category).page(page).per(QTT_PER_PAGE) }

  scope :search, ->(term, page = 1) {
    where("title LIKE ?", "%#{term}%").page(page).per(QTT_PER_PAGE)
  }

  # paperclip
  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#", thumb: "100x100>" },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  # gem money-rails
  monetize :price_cents
  private
    def markdown_to_html
      options = {
        filter_html: true,
        link_attributes: {
          rel: "nofollow",
          target: "_blank"
        }
      }

      extensions = {
        space_after_headers: true,
        autolink: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)

      self.description = markdown.render(self.description_md).html_safe
    end
end
