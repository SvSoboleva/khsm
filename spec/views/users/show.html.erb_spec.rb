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
  context 'when user signed in' do
    before do
      user = FactoryGirl.create(:user)
      sign_in user
      render
    end

    it 'renders change password button' do
      expect(rendered).to match 'Сменить имя и пароль'
    end
  end

  context 'when user not signed in' do
    it 'does not render change password button' do
      expect(rendered).not_to match 'Сменить имя и пароль'
    end
  end

  #Проверяем вывод фрагментов с игрой, пользователь не создал ни одной игры
  it 'renders game fragments if its not exists' do
    user = FactoryGirl.create(:user)
    stub_template 'users/_game.html.erb' => 'User game goes here'
    render
    expect(rendered).not_to have_content 'User game goes here'
  end

  #Проверяем вывод фрагментов с игрой, игры есть
  it 'renders game fragments' do
    user = FactoryGirl.create(:user)
    @games =[
        FactoryGirl.create(:game,  user: user, prize: 1000),
        FactoryGirl.create(:game,  user: user, prize: 2000)
    ]
    stub_template 'users/_game.html.erb' => 'User game goes here'
    render
    expect(rendered).to have_content 'User game goes here'
  end

end
