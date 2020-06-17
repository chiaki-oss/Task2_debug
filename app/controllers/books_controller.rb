class BooksController < ApplicationController
  #追記
  before_action :authenticate_user!
  #ログインしてなければ飛ばない
  before_action :ensure_correct_user,only: [:edit, :update, :destroy]
  #編集制限

  def show
  	@book = Book.find(params[:id])
    @user = @book.user #追記
    @newbook = Book.new #新規投稿用(追記)
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id #追記(postid =userid)
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render :edit
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  #編集制限（追記）
  def ensure_correct_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body, :user_id) #bod/user/_id追記
  end
end
