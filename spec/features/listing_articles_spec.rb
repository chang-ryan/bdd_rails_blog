require "rails_helper"

RSpec.feature "Creating articles" do
  before do
    @article1 = Article.create(title: "The First Article", body: "Lorem my ipsum, dawg.")
    @article2 = Article.create(title: "The Second Article", body: "The body of my second article.")
  end

  scenario "User navigates to articles index" do
    visit "/"
    
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end
end