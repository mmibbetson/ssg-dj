// SPDX-FileCopyrightText: 2025 Matthew Mark Ibbetson
// SPDX-FileContributor: Matthew Mark Ibbetson
//
// SPDX-License-Identifier: GPL-3.0-or-later

//! CLAP-derive struct definition specifying the command line interface for dn.

use clap::{ArgAction, Parser, Subcommand};

#[derive(Parser)]
#[command(name = "ssg-dj", version = "0.1.0", about = "")]
pub struct Cli {
    #[command(subcommand)]
    pub command: Commands,
}

#[derive(Subcommand)]
pub enum Commands {}
