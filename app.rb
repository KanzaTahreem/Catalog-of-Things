require 'colorize'
require './src/modules/musicmethod'
require './src/modules/genremethod'
require './src/classes/musicalbum'
require './src/classes/items'
require './src/classes/genre'
require_relative './src/modules/game_module'
require_relative './src/modules/book_module'
require_relative './src/modules/label_module'
require_relative './src/modules/genre_module'
require 'json'

class App
  include Methodmusic
  include Genremethod
  include GameModule
  include BookModule
  include LabelModule
  include AuthorModule
  include GenreModule

  def initialize
    @genre = read_genre
    @musicalbums = read_album
    @games = read_game
    @labels = []
    @books = []
    @authors = []
    @genres = []
  end

  def show_menu
    puts "\nPlease choose an option by entering a number from below 👇: \n\n".yellow.underline
    puts '[ 1 ] - List all books'.cyan
    puts '[ 2 ] - List all music albums'.cyan
    puts '[ 3 ] - List of games'.cyan
    puts "[ 4 ] - List all genres (e.g 'Comedy', 'Thriller')".cyan
    puts "[ 5 ] - List all labels (e.g. 'Gift', 'New')".cyan
    puts "[ 6 ] - List all authors (e.g. 'Stephen King')".cyan
    puts '[ 7 ] - Add a book'.cyan
    puts '[ 8 ] - Add a music album'.cyan
    puts '[ 9 ] - Add a game'.cyan
    puts "[ 0 ] - Exit \n\n".cyan
    user_choice = gets.chomp.to_i
    select_option(user_choice)
  end

  # @create_games = create_game

  def select_option(user_choice)
    case user_choice
    when 1..6
      list_items(user_choice)
    when 7..9
      add_items(user_choice)
    when 0
      exit
    else
      invalid_option
    end
  end

  def invalid_option
    puts "\n 🛑 ❌ ❌ Invalid option. Please select a valid input...".red.underline
    show_menu
  end

  def list_items(user_choice)
    case user_choice
    when 1 then list_all_books
    when 2 then list_all_music_albums
    when 3 then list_all_games
    when 4 then list_all_genres
    when 5 then list_all_labels
    when 6 then list_all_authors

    end
    show_menu
  end

  def add_items(user_choice)
    case user_choice
    when 7 then create_book
    when 8 then add_music_album
    when 9 then add_game
    end
    show_menu
  end

  def exit
    puts "Thank you for using the app, see you later!👋  \n\n".blue
  end
end
