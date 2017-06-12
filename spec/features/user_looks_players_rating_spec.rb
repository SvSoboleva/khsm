# Как и в любом тесте, подключаем помощник rspec-rails
require 'rails_helper'

# Начинаем описывать функционал, связанный с созданием игры
RSpec.feature 'USER looks a rating', type: :feature do
  # Чтобы пользователь мог начать игру, нам надо
  # создать пользователя
  let(:users) { [
    FactoryGirl.create(:user, name: 'Мария', balance: 3000),
    FactoryGirl.create(:user, name: 'Артем', balance: 5000)
  ] }

  # и создать 15 вопросов с разными уровнями сложности
  # Обратите внимание, что текст вопроса и вариантов ответа нам
  # здесь важен, так как именно их мы потом будем проверяеть
  let!(:questions) do
    (0..14).to_a.map do |i|
      FactoryGirl.create(
        :question, level: i,
        text: "Когда была куликовская битва номер #{i}?",
        answer1: '1380', answer2: '1381', answer3: '1382', answer4: '1383'
      )
    end
  end

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
