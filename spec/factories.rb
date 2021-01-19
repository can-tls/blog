FactoryBot.define do
  factory :user do
    name { "Can Talas" }
    email {"eliminator-44@hotmail.de"}
    password {"hallo123"}
    id {1}
  end

  factory :micropost do
    content { "content" }
    titel {"content"}
    user_id {1}
  end
end