#!/bin/bash

GEDIT_STARTER_KIT=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
GEDIT_HOME=~/.gnome2/gedit
GEDIT_PLUGIN_DIR=$GEDIT_HOME/plugins
GEDIT_STYLE_DIR=$GEDIT_HOME/styles
LANGUAGE_SPEC_DIR=~/.local/share/gtksourceview-2.0/language-specs
MIME_DIR=~/.local/share/mime

echo "updating submodules"
git submodule update --init

echo -e "\n[PLUGINS]"
for plugin in plugins/*; do
    if [[ -f "scripts/${plugin}.install.sh" ]]; then
        source "$GEDIT_STARTER_KIT/scripts/$plugin.install.sh"
        cd $GEDIT_STARTER_KIT
    else
        pluginname=${plugin/plugins\//}
        echo "installing $pluginname plugin"
        cp -R $GEDIT_STARTER_KIT/$plugin/$pluginname* $GEDIT_PLUGIN_DIR
    fi
done
echo "installing Gedit plugins from Ubuntu repository"
sudo apt-get install gedit-plugins

echo -e "\n[STYLES]"
for style in styles/*; do
    theme=${style:7}
    echo "installing ${theme/.xml/} style"
    cp $GEDIT_STARTER_KIT/$style $GEDIT_STYLE_DIR
done

echo -e "\n[LANGUAGE SPECS]"
for langspec in language-specs/*; do
    lang=${langspec:15}
    echo "installing ${lang/.lang/} language-spec"
    cp $GEDIT_STARTER_KIT/$langspec $LANGUAGE_SPEC_DIR
done
