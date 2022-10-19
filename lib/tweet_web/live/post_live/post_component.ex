defmodule TweetWeb.PostLive.PostComponent do
  use TweetWeb, :live_component

  def render(assigns) do
    ~H"""
    <div id={"post-#{@post.id}"} class="post">
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
      <div class="row">
        <div class="column column-10" style="background-color: #ddd;">
          <div class="post-avatar"> </div>
        </div>
        <div class="column column-90 post-body">
          <b>@<%= @post.username %> </b>
          <br/>
          <%= @post.body %>
        </div>
      </div>

      <div class="row">
        <div class="column">
        <a href="#" phx-click="like" phx-target={@myself}>
           <i class="fas fa-heart"></i> <%= @post.likes_count %>
           <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'> </script>
        </a>
        </div>
        <div class="column">
        <a href="#" phx-click="repost" phx-target={@myself}>
            <i class="fas fa-retweet"> </i> <%= @post.reposts_count %>
          </a>
        </div>

        <div class="column">
          <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
           <i class='fas fa-edit'></i>
          <% end %>
        </div>
        <div>
          <%= link to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] do %>
            <i class="far fa-trash-alt"></i>
          <% end %>
        </div>
      </div>
    </div>
  """
  end

  def handle_event("like", _, socket) do
    Tweet.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end
  def handle_event("repost", _, socket) do
    Tweet.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end

end
