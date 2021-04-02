class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def errors
    @user_guesses - normalize_letters(@letters)
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def errors_made
    errors.length
  end

  def letters_to_guess
    @letters.map do |letter|
      letter if @user_guesses.include?(normalize_letter(letter))
    end
  end

  def lost?
    errors_allowed == 0
  end

  def normalize_letter(letter)
    case letter
    when "Ё" then "Е"
    when "Й" then "И"
    else letter
    end
  end

  def normalize_letters(letters)
    letters.map { |letter| normalize_letter(letter) }
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    normalize_letter = normalize_letter(letter)
    if !over?
      unless @user_guesses.include?(normalize_letter)
        @user_guesses << normalize_letter
      end
    end
  end

  def won?
    (normalize_letters(@letters) - @user_guesses).empty?
  end

  def word
    @letters.join
  end
end
