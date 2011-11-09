GEDIT_DIR = ~/.local/share/gedit
GSV3_DIR = ~/.local/share/gtksourceview-3.0
MIME_DIR = ~/.local/share/mime

install:
	@if [ ! -d $(GSV3_DIR)/styles ]; then \
		mkdir -p $(GSV3_DIR)/styles;\
	fi
	@echo "installing styles";
	@cp -R styles/* $(GSV3_DIR)/styles;

	@if [ ! -d $(GSV3_DIR)/language-specs ]; then \
		mkdir -p $(GSV3_DIR)/language-specs;\
	fi
	@echo "installing language-specs";
	@cp -R language-specs/* $(GSV3_DIR)/language-specs;

	@if [ ! -d $(MIME_DIR)/packages ]; then \
		mkdir -p $(MIME_DIR)/packages;\
	fi
	@echo "installing MIME";
	@cp -R mime/* $(MIME_DIR)/packages;
	@update-mime-database $(MIME_DIR)
