require_relative '../classes/book'
require_relative './label_module'
require_relative './authors_module'
require_relative './genre_module'
require_relative './valid_date'

module BookModule
  include LabelModule
  include AuthorModule
  include GenreModule

  def list_all_books
    if @books.empty?
      puts "No Books to Show 🚫 Please add some books \n"
    else
      @books.each_with_index do |book, index|
        print "[#{index + 1}]: Title: #{book.title} ╏ Author: #{book.author.first_name} #{book.author.last_name} | Label: #{book.label.title}"
        print " Archived: #{book.archived} ╏ Publisher: #{book.publisher} ╏ Publication_date: #{book.publish_date} ╏"
        print " Cover State: #{book.cover_state} ╏ Genre: #{book.genre.name}"
      end
    end
  end

  def create_book
    print 'Enter the title of the book: '
    title = gets.chomp
    print 'Enter the publisher of the book: '
    publisher = gets.chomp
    date = get_valid_date
    print 'Enter thr cover state of the book e.g (new, good, acceptable, bad): '
    cover = gets.chomp

    print 'Do you want to archive this book? (y/n): '
    archive_choice = gets.chomp
    archived = (archive_choice == 'y')
    book = Book.new(title, date, publisher, cover, archived: archived)
    if archived
      if book.move_to_archive
        print 'Do you want to confirm archiving this book (y/n): '
        confirm = gets.chomp
        if confirm == 'y'
          book = Book.new(title, date, publisher, cover, archived: archived)
          @books << book
          puts "Book created and archived successfully 📕✅"
        elsif confirm == 'n'
          puts "Book not archived"
        else
          puts 'Please add valid input'
        end
      else
        puts "The book is not old enough to be archived"
        @books << book
        puts "Book created successfully 📕✅"
      end
    else
      @books << book
      puts "Book created successfully 📕✅"
    end
  
    author = get_author
    author.add_item(book)
    puts "Author added for book #{book.title} successfully 👤✅"

    label = get_book_label
    label.add_item(book)
    puts "Label added for book #{book.title} successfully 📘✅"

    genre = get_genre
    genre.add_item(book)
    puts "Genre added for label #{book.title} successfully 🤹‍♂️✅"
  end
end
