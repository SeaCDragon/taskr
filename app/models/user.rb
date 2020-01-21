class User < ApplicationRecord
	attr_accessor :remember_token

	before_save {email.downcase!}
	validates :name, presence: true, length: {maximum: 60, minimum: 6}

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length:{maximum: 255}, format:{with: EMAIL_REGEX},
	uniqueness: {case_sensitive: false}

	has_secure_password
	validates :password, presence: true, length: {minimum: 6}

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

	def authenticated?(remember_token)
		#Password.new retrieves the digest from the database.
		# .is_password method hashes the arguement passed to this function and compares it to the digest
		# the remember_token arguement in this method is NOT the attribute in this user, they just have the
		#same name.
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end
end
