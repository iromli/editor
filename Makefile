GEDIT_DIR = ~/.local/share/gedit
GSV3_DIR = ~/.local/share/gtksourceview-3.0

install:
	@if [ ! -d $(GSV3_DIR) ]; then \
		mkdir -p $(GSV3_DIR)/{styles};\
	fi
	@cp -R styles $(GSV3_DIR)/styles;
