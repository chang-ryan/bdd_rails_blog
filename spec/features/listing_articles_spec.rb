require "rails_helper"

RSpec.feature "Creating articles" do
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @article1 = @john.articles.build(title: "The First Article", body: "Lorem my ipsum, dawg.")
    @article2 = @john.articles.build(title: "The Second Article", body: "The body of my second article.")
    @article1.save
    @article2.save
  end

  scenario "with articles created and user NOT signed in" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).to_not have_link("New Article")
  end
  
  scenario "with articles created and user signed in" do
    login_as(@john)
    visit "/"
    
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).to have_link("New Article")
  end
  
  scenario "with no articles" do
    Article.delete_all
    visit "/"
    
    expect(page).to_not have_content(@article1.title)
    expect(page).to_not have_content(@article1.body)
    expect(page).to_not have_content(@article2.title)
    expect(page).to_not have_content(@article2.body)
    expect(page).to_not have_link(@article1.title)
    expect(page).to_not have_link(@article2.title)

    within ("h1#no-articles") do
      expect(page).to have_content("No articles yet!")
    end
  end
  
end