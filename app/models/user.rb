class User < ActiveRecord::Base
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true,
                  :length => {:maximum => 50}
  validates :email, :presence => true,
                   :format => {:with => email_regex},
                   :uniqueness => true
  
  def password
    @password
  end
  
  def password=(pass)
    return unless pass
    @password = pass
    generate_password(pass)
    
  end
  
  private
  def generate_password(pass)
    salt = Array.new(10){rand(1024).to_s(36)}.join
    self.salt,self.hashed_password = 
      salt,Digest::SHA256.hexdigest(pass+salt)
  end
end
