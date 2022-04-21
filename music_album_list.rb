require_relative 'music_album'
require 'json'

class MusicList
  def initialize
    @albums = []
  end

  def add_music_album
    puts 'The Album is on Spotify? (y/n)'
    spotify = gets.chomp
    spotify = true if spotify == 'y'

    puts 'Please enter the publish date?'
    publish_date = gets.chomp

    puts 'Is the album archived? (y/n)'
    archived = gets.chomp

    archived = true if archived == 'y'

    @albums << MusicAlbum.new(spotify, publish_date, archived)
    puts 'Album registered succesfully'
  end

  def list_all_music_albums
    @albums.each do |album|
      puts "publish_date: #{album.publish_date}, archived: #{album.archived},
      on_spotify: #{album.on_spotify}"
    end
  end

  def save_albums
    albums = @albums.map do |album|
      {
        spotify: album.on_spotify,
        publish_date: album.publish_date,
        archived: album.archived,
        id: album.id
      }
    end

    json_album = JSON.generate(albums)
    File.write('music_album.json', "#{json_album}\n", mode: 'w')
  end

  def show_albums
    file_path = 'music_album.json'
    if File.exist?(file_path)
      raw_data = File.read('music_album.json')
      clean_data = JSON.parse(raw_data)
      clean_data.map do |album|
        @albums << MusicAlbum.new(album['spotify'], album['publish_date'], album['archived'], album['id'])
      end
    else
      File.new('music_album.json', 'w')
    end
  end
end
