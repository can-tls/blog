FactoryBot.define do
  factory :user do
    name { "Can Talas" }
    email {"eliminator-44@hotmail.de"}
    password {"hallo123"}
  end

  factory :micropost do
    content { "content" }
    email {"content"}
    password {"hallo123"}
  end
end