class User < ActiveRecord::Base
  TYPES = %w[Customer Seller Admin]


    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable

    has_and_belongs_to_many :sites
    has_and_belongs_to_many :listings

    has_many :listings
    has_many :devices

    validates :email, presence: true
    validates :mobile, presence: true, allow_nil: true

    scope :seller_or_admin, -> { where(type: ['Seller', 'Admin']) }
    scope :customer,        -> { where(type: 'Customer') }


    def to_s
      name.presence || email
    end

    def is_seller?
      self.class.name == 'Seller'
    end

    def is_admin?
      self.class.name == 'Admin'
    end


end
