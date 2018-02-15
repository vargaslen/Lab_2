require 'spec_helper'
require 'hangperson_game'

describe HangpersonGame do
  # helper function: make several guesses
  def guess_several_letters(game, letters)
    letters.chars do |letter|
      game.guess(letter)
    end
  end

  describe 'nueva', :pending => true do
    it "toma un argumento y devuelve instancia de clase HangpersonGame" do
      @hangpersonGame = HangpersonGame.new('glorp')
      expect(@hangpersonGame).to be_an_instance_of(HangpersonGame)
      expect(@hangpersonGame.word).to eq('glorp')
      expect(@hangpersonGame.guesses).to eq('')
      expect(@hangpersonGame.wrong_guesses).to eq('')
    end
  end

  describe 'adivina', :pending => true do
    context 'correctamente' do
      before :each do
        @game = HangpersonGame.new('garply')
        @valid = @game.guess('a')
      end
      it 'cambia cadena de aciertos', :pending => true do
        expect(@game.guesses).to eq('a')
        expect(@game.wrong_guesses).to eq('')
      end
      it 'devuelve true', :pending => true do
        expect(@valid).not_to be false
      end
    end
    context 'incorrectamente' do
      before :each do
        @game = HangpersonGame.new('garply')
        @valid = @game.guess('z')
      end
      it 'cambia cadena de desaciertos', :pending => true do
        expect(@game.guesses).to eq('')
        expect(@game.wrong_guesses).to eq('z')
      end
      it 'devuelve true', :pending => true do
        expect(@valid).not_to be false
      end
    end
    context 'misma letra repetida' do
      before :each do
        @game = HangpersonGame.new('garply')
        guess_several_letters(@game, 'aq')
      end
      it 'no cambia cadena de aciertos', :pending => true do
        @game.guess('a')
        expect(@game.guesses).to eq('a')
      end
      it 'no cambia cadena de desaciertos', :pending => true do
        @game.guess('q')
        expect(@game.wrong_guesses).to eq('q')
      end
      it 'devuelve false', :pending => true do
        expect(@game.guess('a')).to be false
        expect(@game.guess('q')).to be false
      end
      it 'indiferente a mayuscula', :pending => true do
        expect(@game.guess('A')).to be false
        expect(@game.guess('Q')).to be false
        expect(@game.guesses).not_to include('A')
        expect(@game.wrong_guesses).not_to include('Q')
      end
    end
    context 'inválido' do
      before :each do
        @game = HangpersonGame.new('foobar')
      end
      it 'Arroja un error si la cadena es vacia', :pending => true do
        expect { @game.guess('') }.to raise_error(ArgumentError)
      end
      it 'Arroja un error si no es letra', :pending => true do
        expect { @game.guess('%') }.to raise_error(ArgumentError)
      end
      it 'Arroja un error si el argumento es nulo', :pending => true do
        expect { @game.guess(nil) }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'Se muestran los aciertos en la palabra', :pending => true do
    before :each do
      @game = HangpersonGame.new('banana')
    end
    # for a given set of guesses, what should the word look like?
    @test_cases = {
      'bn' =>  'b-n-n-',
      'def' => '------',
      'ban' => 'banana'
    }
    @test_cases.each_pair do |guesses, displayed|
      it "Debería mostrar '#{displayed}' cuando los aciertos son '#{guesses}'" do
        guess_several_letters(@game, guesses)
        expect(@game.word_with_guesses).to eq(displayed)
      end
    end
  end

  describe 'Estado del juego' do
    before :each do
      @game = HangpersonGame.new('dog')
    end
    it 'Debería ser: win, si se aciertan todas', :pending => true do
      guess_several_letters(@game, 'ogd')
      expect(@game.check_win_or_lose).to eq(:win)
    end
    it 'Debería ser: lose, luego de 7 desaciertos', :pending => true do
      guess_several_letters(@game, 'tuvwxyz')
      expect(@game.check_win_or_lose).to eq(:lose)
    end
    it 'Continúa jugando: play, si no es win o lose', :pending => true do
      guess_several_letters(@game, 'do')
      expect(@game.check_win_or_lose).to eq(:play)
    end
  end
end
