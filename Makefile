GEDIT_DIR = ~/.local/share/gedit

install:
	@if [ ! -d $(GEDIT_DIR) ]; then \
		mkdir -p $(GEDIT_DIR)/{plugins,styles};\
	fi
	@cp -R styles $(GEDIT_DIR)/styles;
