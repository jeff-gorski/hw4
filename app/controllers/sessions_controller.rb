class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}."
        redirect_to "/places"
      else
        jokes = [
          "Wrong password! What did the password say to the hacker? You'll never get inside my head.",
          "Wrong password! Why did the password go to therapy? It had too many issues to unlock.",
          "Wrong password! What's a password's least favourite game? Guess who.",
          "Wrong password! Why was the password so short? It had low self-esteem.",
          "Wrong password! What did the password say to the username? Without you, I just don't log in."
        ]
        flash["notice"] = jokes.sample
        redirect_to "/login"
      end
    else
      jokes = [
        "No account found! Did you forget you existed? Even your account doesn't know who you are.",
        "No account found! You're like a ghost — no trace of you in our system.",
        "No account found! Are you sure you signed up? Your account is playing hide and seek... and winning.",
        "No account found! Even Waldo has been found more times than your account.",
        "No account found! Our database looked everywhere and came back empty-handed."
      ]
      flash["notice"] = jokes.sample
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    jokes = [
      "Goodbye! Why did the user log out? Because they couldn't handle any more cookies.",
      "Goodbye! Logging out is like leaving a party — you always wonder if anything fun happens after you leave.",
      "Goodbye! Why did the user log out? Their session had too much drama.",
      "Goodbye! You've logged out. Don't worry, your data will miss you.",
      "Goodbye! Logging out? Even your browser looks sad right now."
    ]
    flash["notice"] = jokes.sample
    redirect_to "/login"
  end
end