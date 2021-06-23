SDL_GAME_VERSION = 0.01
SDL_GAME_SOURCE = sdl_game-$(SDL_GAME_VERSION).tar.gz
SDL_GAME_SITE = http://intemslab.ru
SDL_GAME_INSTALL_STAGING = YES
SDL_GAME_INSTALL_TARGET = YES
SDL_GAME_DEPENDENCIES = sdl2 sdl2_mixer sdl2_image sdl2_ttf host-pkgconf

#$(eval $(autotools-package))
$(eval $(cmake-package))
