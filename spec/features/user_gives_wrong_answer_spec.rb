# Как и в любом тесте, подключаем помощник rspec-rails
require 'rails_helper'

# Начинаем описывать функционал, связанный с созданием игры
RSpec.feature 'USER creates a game', type: :feature do
  # Чтобы пользователь мог начать игру, нам надо
  # создать пользователя
  let(:user) { FactoryGirl.create(:user, name: 'Мария') }

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
    login_as user
  end

  # Сценарий успешного создания игры
  scenario 'successfully' do
    # Заходим на главную
    visit '/'

    # Кликаем по ссылке "Новая игра"
    click_link 'Новая игра'

    # Ожидаем, что попадем на нужный url
    expect(page).to have_current_path '/games/1'

    # Ожидаем, что трижды правильно ответили на вопрос
    (0..2).to_a.map do |i|
      expect(page).to have_content "Когда была куликовская битва номер #{i}?"
      click_link '1380'
    end

    # неправильный ответ
    click_link '1381'

    # Ожидаем, что на экране профиль игрока
    expect(page).to have_content 'Мария'
    expect(page).to have_content 'проигрыш'
    expect(page).to have_content '0 ₽'
  end
end
