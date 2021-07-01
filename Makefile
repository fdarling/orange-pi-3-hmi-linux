BUILDROOT_DIR = buildroot
DEFCONFIG_NAME = orangepi_3_defconfig
DEFCONFIG_FILE_SRC = $(DEFCONFIG_NAME)
DEFCONFIG_FILE_DST = $(BUILDROOT_DIR)/configs/$(DEFCONFIG_NAME)
BOARD_DIR_NAME = orangepi-3
BOARD_FILES_SRCS := $(shell find $(BOARD_DIR_NAME) -type f)
BOARD_FILES_DSTS := $(patsubst %,$(BUILDROOT_DIR)/board/orangepi/%,$(BOARD_FILES_SRCS))
BOARD_DIR_SRC = $(BOARD_DIR_NAME)
BOARD_DIR_DST = $(BUILDROOT_DIR)/board/orangepi/orangepi-3
GAME_PKG_SRC = $(BOARD_DIR_NAME)/package/sdl_game
GAME_PKG_DST = $(BUILDROOT_DIR)/package/qt5_test_app
QT5_APP_PKG_SRC = $(BOARD_DIR_NAME)/package/qt5_test_app
QT5_APP_PKG_DST = $(BUILDROOT_DIR)/package/sdl-game
FIRMWARE_DIR_SRC = firmware
FIRMWARE_DIR_DST = $(BOARD_DIR_DST)/rootfs_overlay/lib/firmware/brcm
FIRMWARE_AG_NAME = fw_bcm43456c5_ag.bin
FIRMWARE_AG_SRC = $(FIRMWARE_DIR_SRC)/$(FIRMWARE_AG_NAME)
FIRMWARE_AG_DST = $(FIRMWARE_DIR_DST)/$(FIRMWARE_AG_NAME)
FIRMWARE_BRCM_NAMES = \
	BCM4345C5.hcd \
	brcmfmac43456-sdio.bin \
	brcmfmac43456-sdio.txt
FIRMWARE_BRCM_DSTS = $(patsubst %,$(FIRMWARE_DIR_DST)/%,$(FIRMWARE_BRCM_NAMES))

all: $(DEFCONFIG_FILE_DST) $(BOARD_FILES_DSTS) $(FIRMWARE_AG_DST) $(FIRMWARE_BRCM_DSTS) $(GAME_PKG_DST) $(QT5_APP_PKG_DST)
	make -C $(BUILDROOT_DIR) $(DEFCONFIG_NAME)
	make -C $(BUILDROOT_DIR)

$(DEFCONFIG_FILE_DST): $(DEFCONFIG_FILE_SRC)
	cp $(DEFCONFIG_FILE_SRC) $(DEFCONFIG_FILE_DST)

$(GAME_PKG_DST): $(GAME_PKG_SRC)
	cp -r $< $@
	cp $(BOARD_DIR_NAME)/package/Config.in $(BUILDROOT_DIR)/package

$(QT5_APP_PKG_DST): $(QT5_APP_PKG_SRC)
	cp -r $< $@
#	cp $(BOARD_DIR_NAME)/package/Config.in $(BUILDROOT_DIR)/package

$(FIRMWARE_AG_DST): $(FIRMWARE_AG_SRC)
	mkdir -p $(dir $@)
	cp $< $@

$(BOARD_DIR_DST)/%: $(BOARD_DIR_SRC)/%
	mkdir -p $(dir $@)
	cp $< $@

$(FIRMWARE_DIR_DST)/%: $(FIRMWARE_DIR_SRC)/brcm/%
	mkdir -p $(dir $@)
	cp $< $@

clean:
	rm -f $(DEFCONFIG_FILE_DST)
	rm -rf $(BOARD_DIR_DST)
	rm -rf $(GAME_PKG_DST)
	rm -rf $(QT5_APP_PKG_DST)

.PHONY: all clean
