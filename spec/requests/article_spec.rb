require 'rails_helper'

RSpec.describe "Article", type: :request do
  before do
    @article = Article.create(title: "A New Title", body: "Lorem my ipsum, bro.")
  end
  
  describe "GET /article/:id" do
    context "with existing article" do
      before { get "/articles/#{@article.id}"}

      it "handles existing article" do
        expect(response.status).to eq(200)
      end
    end

    context "with non-existing article" do
      before { get "/articles/no_id" }

      it "handles non-existing article" do
        expect(response.status).to eq(302)
        flash_message = "Uh oh, we couldn't find the article you're looking for."
        expect(flash[:danger]).to eq(flash_message)
      end
    end
  end
end