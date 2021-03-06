class NicknameValidator < ActiveModel::Validator
  def validate(record)
    if (record.nickname =~ /[^hrungoa]/i )
      record.errors[:nickname] << "Nickname contains invalid characters"
    end
  end
end

class Zombie < ActiveRecord::Base
  attr_accessible :graveyard, :name, :nickname, :level, :date_of_birth, :date_of_death, :date_of_undeath,
  		:hit_points, :description, :active, :wins, :losses, :creator_id, :weapon, :avatar
  audited

  validates :name, :presence=>true, :uniqueness=>true
  validates_with NicknameValidator
  validates :active, :presence=>true
  validates :wins, :presence=>true
  validates :losses, :presence=>true
  validates :weapon, :presence=>true

  has_many :tweets, :dependent => :destroy
  belongs_to :creator, :class_name=>'Zombie'

  after_initialize :init

  # Add zombie avatar (via paperclip library)
  has_attached_file :avatar, :styles => { medium: "300x300>", thumb: "100x100>" }, :default_url => '/assets/missing_:style.png'

  def init
    self.hit_points ||= 100
    self.level ||= 1
  end
end

