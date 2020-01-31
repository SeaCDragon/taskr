class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :reset_token

	has_many :projects, dependent: :destroy

	before_save {email.downcase!}
	before_create :create_activation_digest

	validates :name, presence: true, length: {maximum: 60, minimum: 6}

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length:{maximum: 255}, format:{with: EMAIL_REGEX},
	uniqueness: {case_sensitive: false}

	has_secure_password
	validates :password, presence: true, length: {minimum: 6}, allow_nil: true

	# returns hash digest of string
	def self.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# generates random remember token
	def self.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		# update_attribute is updating a database column, the :remember_digest can be
		# found in one of the migrations. .remember_token is an attribute created by attr_accessor
		# it is local and doesnt exist in the database
		# we use the User.digest method to encrypt the token in the db
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		#Password.new retrieves the digest from the database.
		# .is_password method hashes the arguement passed to this function and compares it to the digest
		# the remember_token arguement in this method is NOT the attribute in this user, they just have the
		#same name.
		BCrypt::Password.new(digest).is_password?( token)
	end

	def activate
		update_columns(activated: true, activated_at: Time.zone.now)
	end

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	def create_reset_digest
		self.reset_token = User.new_token
		update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
	end

	def send_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	private
		def create_activation_digest
			self.activation_token  = User.new_token
			self.activation_digest = User.digest(activation_token)
		end
end
