# --------------------------------------------------------------------------
# OSX Settings
# --------------------------------------------------------------------------

# Disable smart quotes.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false


# --------------------------------------------------------------------------
# Finder
# --------------------------------------------------------------------------

# Display the full POSIX path as the Finder window title
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show the ~/Library folder
chflags nohidden ~/Library


# --------------------------------------------------------------------------
# Messages
# --------------------------------------------------------------------------

# Disable automatic emoji substitution.
defaults write com.apple.messageshelper.MessageController \
    SOInputLineSettings \
    -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes.
defaults write com.apple.messageshelper.MessageController \
    SOInputLineSettings \
    -dict-add "automaticQuoteSubstitutionEnabled" -bool false
