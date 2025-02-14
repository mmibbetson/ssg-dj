# SPDX-FileCopyrightText: 2025 Matthew Mark Ibbetson
# SPDX-FileContributor: Matthew Mark Ibbetson
#
# SPDX-License-Identifier: GPL-3.0-or-later

os := os_family()
home_dir := home_directory()
conf_dir := config_directory()
man_dir := "/usr/local/share/man/man1"
bin_dir := executable_directory()
bin_name := "litr"

# List all recipes by default.
_default:
    @just --list

# Build the project.
build: fix test _compile _doc extras

# Enforce styling and linting.
fix:
    cargo fmt
    cargo clippy --fix

# Run tests.
test filter="":
    cargo test {{filter}}

# Build in release mode.
_compile:
    cargo build --release

# Compile documentation.
_doc:
    cargo doc

# Open developer documentation.
docs:
    cargo doc --open

# Recipe with dependencies.
publish: test build
    cargo publish

# Clean build artifacts.
clean:
    cargo clean

# Install binary via cargo.
install:
    cargo install --path .

# Uninstall binary via cargo.
uninstall:
    cargo uninstall {{bin_name}}

# Install the cargo-xtask dev utility.
install-xtask:
    cargo install --path xtask

# Generate manpage files.
_gen-manpages:
    cargo xtask manpages

# Generate shell completion files.
_gen-completions:
    cargo xtask completions

# Generate extra files like manpages and shell completions.
extras: install-xtask _gen-manpages _gen-completions

# Install manpages.
manpages: _gen-manpages
    mkdir -p {{man_dir}}
    cp ./man/* {{man_dir}}

# Uninstall manpages.
uninstall-manpages:
    rm {{man_dir}}/{{bin_name}}.1
    rm {{man_dir}}/{{bin_name}}-rename.1
    rm {{man_dir}}/{{bin_name}}-new.1
