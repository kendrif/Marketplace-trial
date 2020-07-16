module ApplicationHelper
  def author_of(resource)
    user_signed_in? && resource.user_id == current_user.id
  end

  def cart_count_over_one
    if @cart.line_items.count > 0 
      return "<span class='tag is-dark'>#{@cart.line_items.count}</span>".html_safe
    end
  end  

  def cart_has_items 
    return @cart.line_items.count > 0
  end 

  def admin?
    user_signed_in? && current_user.admin?
  end

  def render_if(condition, record)
    if condition 
      render record
    end
  end

  def stripe_url
    "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{Rails.application.credentials.dig(:stripe, :connect_client_id)}&scope=read_write"
  end

  def stripe_connect_button
    link_to stripe_url, class: "btn-stripe-connect" do
      content_tag :span, "Connect with Stripe"
    end
  end


end
