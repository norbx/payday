module Categories
  class Action
    def self.update_category(record, value)
      record.update()
    end

    def self.valid_category?(value)
      Category.pluck(:name).include?(value)
    end
  end
end
