class MemosController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # @memos = current_user.memos.order(created_at: :desc)
    @q = current_user.memos.ransack(params[:q])

    # @memos = current_user.memos.recent
    # @memos = @q.result(distinct: true).recent
    @memos = @q.result(distinct: true).page(params[:page])

    respond_to do |format|
      format.html
      format.csv{ send_data @memos.generate_csv, filename: "memos-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end
  end
  
  def show
    # @memo = current_user.memos.find(params[:id])
  end
  
  def new
    @memo = Memo.new
  end

  def create
    @memo = current_user.memos.new(memo_params)
    if @memo.save
      MemoMailer.creation_email(@memo).deliver_now
      redirect_to @memo, notice: "メモ「#{@memo.title}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    # @memo = current_user.memos.find(params[:id])
  end

  def update
    # memo = current_user.memos.find(params[:id])
    @memo.update!(memo_params)
    redirect_to memos_path, notice: " メモ「#{@memo.title}」を編集しました。"
  end

  def destroy
    # memo = current_user.memos.find(params[:id])
    @memo.destroy
    redirect_to memos_path, notice: "メモ「#{@memo.title}」を削除しました。"
  end

  def import
    current_user.memos.import(params[:file])
    redirect_to memos_url, notice: "メモを追加しました。"
  end


  private
  
    def memo_params
      params.require(:memo).permit(:title, :description, :image)
    end

    def set_task
      @memo = current_user.memos.find(params[:id])
    end
end
