require 'rails_helper'

# Тест на шаблон users/show.html.erb

RSpec.describe 'users/show', type: :view do
  # Перед каждым шагом мы пропишем в переменную @users пару пользователей
  # как бы имитируя действие контроллера, который эти данные будет брать из базы
  # Обратите внимание, что мы объекты в базу не кладем, т.к. пишем FactoryGirl.build_stubbed
  before(:each) do
  assign(:user, FactoryGirl.build_stubbed(:user, id: 1, name: 'Мария', balance: 5000) )
  #assign(:current_user, FactoryGirl.build_stubbed(:user, id: 1, name: 'Мария', balance: 5000) )
  stub_template 'users/_game.html.erb' => 'User game goes here'
  #assign(:current_user, :user)
    render
  end
  # Проверяем, что шаблон выводит имя  игрока
  it 'renders player name' do

    expect(rendered).to match 'Мария'
  end

  # Проверяем, что шаблон выводит ссылку для смены пароля
  it 'renders possibility to change password' do

    #current_user = user

    render
   # assign(:current_user,  :user )
   # render 'users/show', object: :user, locals: :current_user
    expect(rendered).to match 'Сменить имя и пароль'
  end

  it 'renders game fragments' do

  expect(rendered).to have_content 'User game goes here'
  end

end
