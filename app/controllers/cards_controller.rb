class CardsController < ApplicationController
  def index
    pagy, cards = pagy(Card.all.with_rich_text_content_and_embeds.order('updated_at DESC'), items: 30, size: [])
    render locals: { pagy: pagy, cards: cards }
  end

  def search
    # The simple implementation is to do a wildcard search on one column, title
    # search_scope = Card.where('title ILIKE ?', "%#{params[:q]}%")

    # As an enhancement lets search multiple columns title and body
    # search_scope = Card.where('title ILIKE ? OR body ILIKE ?', "%#{params[:q]}%", "%#{params[:q]}%")

    # Use Textacular gem for more advanced search syntax, "grand view" or shark
    search_scope =
      Card.with_rich_text_content_and_embeds.web_search(
        { title: params[:q], subtitle: params[:q], body: params[:q] },
        false
      )

    # Pagy gem does pagination for us
    pagy, cards = pagy(search_scope, items: 30, size: [], params: { q: params[:q] })

    # # If we wanted to optimize, we could only send back a partial when HTMX makes a request
    # if htmx?
    #   render partial: 'search_results', layout: false, locals: {pagy: pagy, cards: cards}
    # else
    #   render locals: {pagy: pagy, cards: cards}
    # end

    render locals: { pagy: pagy, cards: cards }
  end

  def show
    card = Card.find(params[:id])
    render locals: { card: card }
  end

  def new
    card = Card.new
    render locals: { card: card }
  end

  def edit
    card = Card.find(params[:id])
    authorize card
    render locals: { card: card }
  end

  def update
    card = Card.find(params[:id])
    authorize card

    if card.update(card_params)
      # The t method is for i18n (Internationalization) or having your app work in multiple languages
      redirect_to card, notice: t('card_saved_msg')
    else
      flash.now[:alert] = 'Error saving Card'
      render :edit, locals: { card: card }
    end
  end

  def create
    card = Card.new(card_params)

    if card.valid?
      card.save

      # The t method is for i18n (Internationalization) or having your app work in multiple languages
      redirect_to card, notice: t('card_saved_msg')
    else
      flash.now[:alert] = 'Error saving Card'
      render :new, locals: { card: card }
    end
  end

  private

  def card_params
    params.require(:card).permit(:title, :subtitle, :body, :content)
  end
end
