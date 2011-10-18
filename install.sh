GEDIT_STARTER_KIT=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
GEDIT_HOME=~/.gnome2/gedit
GEDIT_PLUGIN_DIR=$GEDIT_HOME/plugins
GEDIT_STYLE_DIR=$GEDIT_HOME/styles
LANGUAGE_SPEC_DIR=~/.local/share/gtksourceview-2.0/language-specs
MIME_DIR=~/.local/share/mime

echo -e "\n[PLUGINS]"
if [[ ! -d $GEDIT_PLUGIN_DIR ]]; then
    mkdir -p $GEDIT_PLUGIN_DIR
fi
for plugin in plugins/*; do
    # checks if custom installer is exist
    if [[ -f "scripts/${plugin}.install.sh" ]]; then
        source "$GEDIT_STARTER_KIT/scripts/$plugin.install.sh"

    # checks if installer provided in plugin directory
    elif [[ -f $GEDIT_STARTER_KIT/$plugin/install.sh ]]; then
        source $GEDIT_STARTER_KIT/$plugin/install.sh

    # checks if Makefile provided in plugin directory
    elif [[ -f $GEDIT_STARTER_KIT/$plugin/Makefile ]]; then
        make -f $GEDIT_STARTER_KIT/$plugin/Makefile install

    # generic installer
    else
        pluginname=${plugin/plugins\//}
        echo "installing $pluginname plugin"
        cp -R $GEDIT_STARTER_KIT/$plugin/$pluginname* $GEDIT_PLUGIN_DIR
    fi

    # short circuit to ensure this block is executed from this directory
    if [[ $PWD != $GEDIT_STARTER_KIT ]]; then
        cd $GEDIT_STARTER_KIT
    fi
done

if [[ ! -z `which apt-get` ]]; then
    echo "installing/updating Gedit plugins from Ubuntu/Debian repository"
    sudo apt-get install gedit-plugins
fi

# THEMES
echo -e "\n[STYLES]"
if [[ ! -d $GEDIT_STYLE_DIR ]]; then
    mkdir -p $GEDIT_STYLE_DIR
fi
for style in styles/*; do
    theme=${style:7}
    echo "installing ${theme/.xml/} style"
    cp $GEDIT_STARTER_KIT/$style $GEDIT_STYLE_DIR
done

# LANGUAGE SPEC
echo -e "\n[LANGUAGE SPECS]"
if [[ ! -d $LANGUAGE_SPEC_DIR ]]; then
    mkdir -p $LANGUAGE_SPEC_DIR
fi
for langspec in language-specs/*; do
    lang=${langspec:15}
    echo "installing ${lang/.lang/} language-spec"
    cp $GEDIT_STARTER_KIT/$langspec $LANGUAGE_SPEC_DIR
done

# MIME
echo -e "\n[MIME]"
if [[ ! -d $MIME_DIR/packages ]]; then
    mkdir -p $MIME_DIR/packages
fi
for mime in mime/*; do
    mime=${mime:5}
    echo "installing ${mime/.xml/} MIME"
    cp $GEDIT_STARTER_KIT/mime/$mime $MIME_DIR/packages
done
update-mime-database $MIME_DIR
