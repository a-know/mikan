FactoryGirl.define do
  factory :watering do
    # ここらへん、 trait を使ったほうがいいのかな？
    # http://techracho.bpsinc.jp/morimorihoge/2013_08_23/12744
    user
    mikanz
  end
end
