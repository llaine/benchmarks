module Company
  def self.all
    entries ||= DB[:companies].select(:id, :name).limit(100).entries
  end
end
