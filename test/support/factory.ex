defmodule MentalHealthMatters.Factory do
  use ExMachina.Ecto, repo: MentalHealthMatters.Repo

  def user_client_factory do
    %MentalHealthMatters.Account.User{
      name:  sequence(:name,  &"client_name-#{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      is_client: true,
      is_coach: false,
      is_manager: false
    }
  end

  def user_coach_factory do
    %MentalHealthMatters.Account.User{
      name:  sequence(:name,  &"coach_name-#{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      is_client: false,
      is_coach: true,
      is_manager: false
    }
  end

  def user_manager_factory do
    %MentalHealthMatters.Account.User{
      name:  sequence(:name,  &"manager_name-#{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      is_client: false,
      is_coach: false,
      is_manager: true
    }
  end

  def meeting_factory do
    %MentalHealthMatters.Session.Meeting{
      meeting_time: NaiveDateTime.utc_now(),
      client: build(:user_client),
      coach: build(:user_coach)
    }
  end
end
