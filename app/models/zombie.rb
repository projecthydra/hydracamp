class Zombie < ActiveRecord::Base
  attr_accessible :graveyard, :name, :nickname, :level, :nickname, :date_of_death,
  		:hit_points, :description, :active, :wins, :losses

  validates :name, :presence=>true, :uniqueness=>true
  validates :active, :presence=>true
  validates :wins, :presence=>true
  validates :losses, :presence=>true

  has_many :tweets, :dependent => :destroy
  belongs_to :creator, :class_name=>'Zombie'

  after_initialize :init

  def init
    self.hit_points ||= 100
    self.level ||= 1
  end
end
