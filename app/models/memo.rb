class Memo < ApplicationRecord
  has_one_attached :image
  validates :title, presence: true, length:{maximum:30}

  belongs_to :user

  scope :recent, -> {order(created_at: :desc)}

  def self.ransackable_attributes(auth_object = nil)
    %w[title created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  # csv_loader
  def self.csv_attributes
    ["title","description","created_at","updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |memo|
        csv << csv_attributes.map{ |attr| memo.send(attr)}
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      memo = new
      memo.attributes = row.to_hash.slice(*csv_attributes)
      memo.save!
    end
  end
end
