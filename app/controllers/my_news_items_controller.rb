# frozen_string_literal: true

class MyNewsItemsController < SessionController
  before_action :set_representative, except: :article_url
  before_action :set_representatives_list, except: :article_url
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  # iter2 -- begin
  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def search
    @representatives = Representative.all
    @issues_list = [
      'Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare', 'Abortion',
      'Student Loans', 'Gun Control', 'Unemployment', 'Climate Change', 'Homelessness', 'Racism',
      'Tax Reform', 'Net Neutrality', 'Religious Freedom', 'Border Security', 'Minimum Wage', 'Equal Pay'
    ]
    @news_item = NewsItem.new
  end

  def save
    response = ApplicationHelper.parse_article_obj(params[:article])
    @news_item = NewsItem.new(title:             response[0],
                              description:       response[1],
                              link:              response[2],
                              representative_id: params[:representative_id],
                              issue:             params[:issue],
                              rating:            params[:rating])
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def article_url
    redirect_to params[:link], allow_other_host: true
  end

  # iter2 -- end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue, :rating)
  end
end
