module PlayersHelper

    def player_image(player_id)
        player = Player.find!(player_id)
        if player.image.attached?
            image_tag player.image
        else
            image_tag 'default_image.jpg'
        end
    end

     

end
