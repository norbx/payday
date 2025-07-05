FactoryBot.define do
  factory :expenses_import do
    state { "pending" }
    file_name { "import_#{Time.now.to_i}.csv" }
  end
end
