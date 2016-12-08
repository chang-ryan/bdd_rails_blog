require 'rails_helper'

RSpec.describe "Article", type: :request do
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    @article = Article.create(title: "A New Title", body: "Lorem my ipsum, bro.", user: @john)
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
  
  describe "GET /article/:id/edit" do
    context "with non user" do
      before { get "/articles/#{@article.id}/edit" }
      it "redirects to sign in page" do
        expect(response.status).to eq(302)
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context "with non owner user" do
      before do
        login_as(@fred)
      end
      before { get "/articles/#{@article.id}/edit" }
      it "redirects to home page" do
        expect(response.status).to eq(302)
        flash_message = "Hey, that's not your article!"
        expect(flash[:notice]).to eq(flash_message)
      end
    end

    context "with user owner" do
      before do
        login_as(@john)
      end
      before { get "/articles/#{@article.id}/edit" }
      it "shows edit page for article" do
        expect(response.status).to eq(200)
      end
    end
  end
  
  describe "DELETE /article/:id" do
    context "with non user" do
      before { delete "/articles/#{@article.id}" }
      it "redirects to sign in page" do
        expect(response.status).to eq(302)
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context "with non owner user" do
      before do
        login_as(@fred)
      end
      before { delete "/articles/#{@article.id}" }
      it "redirects to home page" do
        expect(response.status).to eq(302)
        flash_message = "Hey, that's not your article!"
        expect(flash[:notice]).to eq(flash_message)
      end
    end

    context "with user owner" do
      before do
        login_as(@john)
      end
      before { delete "/articles/#{@article.id}" }
      it "shows edit page for article" do
        expect(response.status).to eq(302)
        flash_message = "Article has successfully been deleted."
        expect(flash[:success]).to eq(flash_message)
      end
    end
  end
end