require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Elo' do
  after do
    Elo.instance_eval { @config = nil }
  end

  it 'should work as advertised' do
    bob  = Elo::Player.new
    jane = Elo::Player.new(rating: 1500)

    game1 = bob.wins_from(jane)
    game2 = bob.loses_from(jane)
    game3 = bob.plays_draw(jane)

    game4 = bob.versus(jane)
    game4.winner = jane

    game5 = bob.versus(jane)
    game5.loser = jane

    game6 = bob.versus(jane)
    game6.draw

    game7 = bob.versus(jane)
    game7.result = 1

    game8 = bob.versus(jane, result: 0)

    expect(bob.rating + jane.rating).to eq(2500)
    expect(bob.rating).to eq(1083)
    expect(jane.rating).to eq(1417)
    expect(bob).not_to be_pro
    expect(bob).to be_starter
    expect(bob.games_played).to eq(8)
    expect(bob.games).to eq([game1, game2, game3, game4, game5, game6, game7, game8])
  end

  describe 'Configuration' do
    it 'default_rating' do
      expect(Elo.config.default_rating).to eq(1000)
      expect(Elo::Player.new.rating).to eq(1000)

      Elo.config.default_rating = 1337

      expect(Elo.config.default_rating).to eq(1337)
      expect(Elo::Player.new.rating).to eq(1337)
    end

    it 'starter_boundry' do
      expect(Elo.config.starter_boundry).to eq(30)
      expect(Elo::Player.new(games_played: 20)).to be_starter

      Elo.config.starter_boundry = 15

      expect(Elo.config.starter_boundry).to eq(15)
      expect(Elo::Player.new(games_played: 20)).not_to be_starter
    end

    it 'default_k_factor and FIDE settings' do
      expect(Elo.config.use_FIDE_settings).to eq(true)
      expect(Elo.config.default_k_factor).to eq(15)

      Elo.config.default_k_factor = 20
      Elo.config.use_FIDE_settings = false

      expect(Elo.config.default_k_factor).to eq(20)
      expect(Elo.config.use_FIDE_settings).to eq(false)
      expect(Elo::Player.new.k_factor).to eq(20)
    end

    it 'pro_rating_boundry' do
      expect(Elo.config.pro_rating_boundry).to eq(2400)

      Elo.config.pro_rating_boundry = 1337

      expect(Elo.config.pro_rating_boundry).to eq(1337)
      expect(Elo::Player.new(rating: 1337)).to be_pro_rating
    end
  end

  describe 'according to FIDE' do
    it 'starter' do
      player = Elo::Player.new
      expect(player.k_factor).to eq(25)
      expect(player).to be_starter
      expect(player).not_to be_pro
      expect(player).not_to be_pro_rating
    end

    it 'normal' do
      player = Elo::Player.new(rating: 2399, games_played: 30)
      expect(player.k_factor).to eq(15)
      expect(player).not_to be_starter
      expect(player).not_to be_pro
      expect(player).not_to be_pro_rating
    end

    it 'pro rating' do
      player = Elo::Player.new(rating: 2400)
      expect(player.k_factor).to eq(10)
      expect(player).to be_starter
      expect(player).to be_pro_rating
      expect(player).not_to be_pro
    end

    it 'historically a pro' do
      player = Elo::Player.new(rating: 2399, pro: true)
      expect(player.k_factor).to eq(10)
      expect(player).to be_starter
      expect(player).not_to be_pro_rating
      expect(player).to be_pro
    end
  end

  describe 'examples for calculating rating correctly' do
    # examples from http://chesselo.com/

    before do
      @a = Elo::Player.new(rating: 2000, k_factor: 10)
      @b = Elo::Player.new(rating: 1900, k_factor: 10)
    end

    it 'winning' do
      @a.wins_from(@b)
      expect(@a.rating).to eq(2004)
    end

    it 'losing' do
      @a.loses_from(@b)
      expect(@a.rating).to eq(1994)
    end

    it 'draw' do
      @a.plays_draw(@b)
      expect(@a.rating).to eq(1999)
    end
  end
end
