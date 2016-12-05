require "rails_helper"

RSpec.feature "Creating articles" do
  before do
    @article = Article.create(title: "The First Article", body: "Lorem my ipsum, dawg.")
  end
  
  scenario "User shows one article" do
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end