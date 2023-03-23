class User < ApplicationRecord

  def to_hash
    attributes
  end
end
