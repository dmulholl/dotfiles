
# -------------------------------------------------------------------------
# OSX Settings
# -------------------------------------------------------------------------

# Disable smart quotes.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false


# -------------------------------------------------------------------------
# Finder
# -------------------------------------------------------------------------

# Display the full POSIX path as the Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show the ~/Library folder
chflags nohidden ~/Library


# -------------------------------------------------------------------------
# Messages
# -------------------------------------------------------------------------

# Disable automatic emoji substitution.
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes.
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false


# -------------------------------------------------------------------------
# Homebrew
# -------------------------------------------------------------------------

# Update the brew installation and packages.
if is_installed brew; then
    if df_yesno "Update Homebrew installation and packages?"; then
        df_arrow "Updating Homebrew..."
        if brew update >> $df_logfile 2>&1; then
            df_check " .. done"
            df_arrow "Upgrading Homebrew packages..."
            if brew upgrade --all >> $df_logfile 2>&1; then
                df_check " .. done"
            else
                df_error " .. failed"
            fi
        else
            df_error " .. failed"
        fi
    fi
fi
