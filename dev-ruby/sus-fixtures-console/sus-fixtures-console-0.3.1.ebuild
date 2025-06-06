# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32 ruby33 ruby34"

RUBY_FAKEGEM_EXTRADOC="readme.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"
RUBY_FAKEGEM_RECIPE_TEST="sus"

inherit ruby-fakegem

DESCRIPTION="Test fixtures for capturing Console output"
HOMEPAGE="https://github.com/socketry/sus-fixtures-console"
SRC_URI="https://github.com/socketry/sus-fixtures-console/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~riscv ~sparc x86"

ruby_add_rdepend "
	>=dev-ruby/console-1.25:1
	>=dev-ruby/sus-0.10:0
"

all_ruby_prepare() {
	sed -i -E 's/require_relative "(.+)"/require File.expand_path("\1")/g' "${RUBY_FAKEGEM_GEMSPEC}" || die

	# Remove the sus configuration which enabled coverage checks.
	# Its dependency is not packaged.
	rm -f config/sus.rb || die
}
