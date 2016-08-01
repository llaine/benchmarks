module Company
  def self.all
    entries ||= DB[:companies].select(:id, :name).limit(100).entries
    DB.disconnect
    entries
  end
end
