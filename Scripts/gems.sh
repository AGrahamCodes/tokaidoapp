#!/bin/sh

cp Tokaido/Gemfile.$RAILS_GEMFILE $TKD_TMP_PATH/Gemfile
cd $TKD_TMP_PATH

echo "Removing existing GEM_HOME to rebuild it"
rm -rf gem_home

echo "Building new GEM_HOME"
mkdir -p $TKD_TMP_PATH/gem_home/ruby/$TKD_RUBY_NAMESPACE

bundle --path gem_home --gemfile Gemfile
gem install bundler -E $NO_DOC_OPTION -i gem_home/ruby/$TKD_RUBY_NAMESPACE

rm -f tokaido-gems.zip
rm -Rf Gems

mkdir Gems
cd Gems
cp -R ../gem_home/ruby/$TKD_RUBY_NAMESPACE .
cd ..
mkdir -p Gems/supps
cp -R $TKD_SUPPLEMENTS_PATH/magick/files Gems/bin_files

zip -r tokaido-gems.zip Gems
