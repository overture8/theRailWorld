class Post < ActiveRecord::Base
  acts_as_taggable
  has_and_belongs_to_many :categories
  has_many :comments
  
  def self.search(page = 1)
    paginate :per_page => 5, :page => page, :order => "created_at DESC"
  end
  
  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  def self.count_of_archives(month, year)
    count(:conditions => ['month(created_at) = ? AND year(created_at) = ?', month, year])
  end
  
  def monthname_created_at
    Date::MONTHNAMES[created_at.month]
  end 
end
