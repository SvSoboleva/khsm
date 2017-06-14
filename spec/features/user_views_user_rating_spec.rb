# Как и в любом тесте, подключаем помощник rspec-rails
require 'rails_helper'

# Начинаем описывать функционал, связанный с созданием игры
RSpec.feature 'USER views a rating', type: :feature do
  # Чтобы пользователь мог начать игру, нам надо
  # создать пользователя
  let(:users) { [
    FactoryGirl.create(:user, name: 'Мария', balance: 3000),
    FactoryGirl.create(:user, name: 'Артем', balance: 5000)
  ] }

  # Перед началом любого сценария нам надо авторизовать пользователя
  before(:each) do
    login_as users[0]
  end

  # Сценарий успешного создания игры
  scenario 'successfully' do
    # Заходим на главную
    visit '/'

    # Ожидаем, что на экране список игроков
    expect(page).to have_content '3 000'
    expect(page).to have_content '5 000'
    expect(page).to have_content 'Мария'
    expect(page).to have_content 'Артем'
  end
end
