hide_desktop() {
    defaults write com.apple.finder CreateDesktop false
    killall Finder
}

show_desktop() {
    defaults write com.apple.finder CreateDesktop true
    killall Finder
}
