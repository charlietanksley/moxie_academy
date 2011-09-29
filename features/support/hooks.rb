Before do
  #Account.destroy
  #User.destroy!
  #Lesson.destroy!
  #Group.destroy!
end

After do |scenario|
  Account.destroy
  User.destroy!
  Lesson.destroy!
  Group.destroy!
end
