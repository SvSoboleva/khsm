# Как и в любом тесте, подключаем помощник rspec-rails
require 'rails_helper'

# Начинаем описывать функционал, связанный с созданием игры
RSpec.feature 'USER gives wrong answer', type: :feature do

  let(:game_w_questions) { FactoryGirl.create(:game_with_questions) }

  # Перед началом любого сценария нам надо авторизовать пользователя
  before(:each) do
    login_as game_w_questions.user
  end

  # Сценарий успешного создания игры
  scenario 'successfully' do
    #game = game_w_questions.game
    visit "/games/1"

    # Ожидаем, что трижды правильно ответили на вопрос
    (1..3).to_a.map do |i|
      expect(page).to have_content "В каком году была космичесая одиссея #{i}?"
      click_link 'D'
    end

    # неправильный ответ
    click_link 'A'

    # Ожидаем, что на экране профиль игрока
    expect(page).to have_content 'проигрыш'
    expect(page).to have_content '0 ₽'
  end
end
