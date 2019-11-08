FactoryBot.define do
  factory :memo do
    title { 'テストを書く' }
    description { 'Ｒspecのテストを書く'}
    user
  end
end
