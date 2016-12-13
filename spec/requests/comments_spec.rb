require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    @article = Article.create(title: "A New Title", body: "Lorem my ipsum, bro.", user: @john)
  end
  
  describe "POST articles/:id/comments" do
    context "with a non-user" do
      before do
        post "/articles/#{@article.id}/comments", params: { comment: { body: "Awesome blog, fam!" } } 
      end

      it "redirects to login page" do
        flash_message = "Please sign in or sign up to do that."
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq(flash_message)
      end
    end
  
    context "with a user signed in" do
      before do
        login_as(@fred)
        post "/articles/#{@article.id}/comments", params: { comment: { body: "Awesome blog, fam!" } } 
      end
    
      it "successfully creates a comment" do
        flash_message = "Comment successfully added."
        expect(response).to redirect_to(article_path(@article.id))
        expect(response.status).to eq(302)
        expect(flash[:success]).to eq(flash_message)
      end
    end
  end
end