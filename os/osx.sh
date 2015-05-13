
# ----------------------------------------------------------------------------
# OSX Settings
# ----------------------------------------------------------------------------

# Always show scrollbars. Options: `WhenScrolling`, `Automatic`, `Always`.
# defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Disable smart quotes.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false


# ----------------------------------------------------------------------------
# Finder
# ----------------------------------------------------------------------------

# Display the full POSIX path as the Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show the ~/Library folder
chflags nohidden ~/Library


# ----------------------------------------------------------------------------
# Messages
# ----------------------------------------------------------------------------

# Disable automatic emoji substitution.
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes.
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false


# ----------------------------------------------------------------------------
# Brew
# ----------------------------------------------------------------------------

# Update brew installation and packages.
if is_installed brew; then
    e_arrow "Updating brew..." && brew update &> /dev/null
    e_arrow "Upgrading brew packages..." && brew upgrade --all &> /dev/null
fi
