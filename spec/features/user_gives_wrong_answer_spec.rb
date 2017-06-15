# Как и в любом тесте, подключаем помощник rspec-rails
require 'rails_helper'

# Начинаем описывать функционал, связанный с созданием игры
RSpec.feature 'USER gives wrong answer', type: :feature do

  let(:game_w_questions) { FactoryGirl.create(:game_with_questions) }

  before(:each) do
    login_as game_w_questions.user
  end

  scenario 'successfully' do
    game = Game.last
    visit game_path(game)

    # Ожидаем, что трижды правильно ответили на вопрос
    3.times do
      expect(page).to have_content "В каком году была космичесая одиссея"
      click_link 'D'
    end

    # неправильный ответ
    click_link 'A'

    # Ожидаем, что на экране профиль игрока
    expect(page).to have_content 'проигрыш'
    expect(page).to have_content '0 ₽'
  end
end
