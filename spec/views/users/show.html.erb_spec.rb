require 'rails_helper'

# Тест на шаблон users/show.html.erb

RSpec.describe 'users/show', type: :view do

  before(:each) do
   assign(:user, FactoryGirl.build_stubbed(:user, id: 1, name: 'Мария', balance: 5000) )
  render
  end
  # Проверяем, что шаблон выводит имя  игрока
  it 'renders player name' do
    expect(rendered).to match 'Мария'
  end

  # Проверяем, что шаблон выводит ссылку для смены пароля только для current_user
  it 'renders possibility to change password' do
    expect(rendered).not_to match 'Сменить имя и пароль'
    user = FactoryGirl.create(:user)
    sign_in user
    render
    expect(rendered).to match 'Сменить имя и пароль'
  end

  it 'renders game fragments' do
    #stub_template 'users/_game.html.erb' => 'User game goes here'
    #render
    #expect(rendered).to have_content 'User game goes here'
    user = FactoryGirl.create(:user)
    @games =[
      FactoryGirl.create(:game,  user: user, current_level: 10, prize: 1000),
      FactoryGirl.create(:game,  user: user, prize: 2000)
    ]
    render
    expect(rendered).to match '1 000 ₽'
  end

end
