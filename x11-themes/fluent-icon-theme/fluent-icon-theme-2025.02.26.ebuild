# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ie. 2021.12.20 -> 2021-12-20
MY_PV="${PV//./-}"
MY_PN="${PN^}"

inherit xdg

DESCRIPTION="Fluent icon theme for Linux desktops"
HOMEPAGE="https://github.com/vinceliuice/Fluent-icon-theme/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/vinceliuice/${MY_PN}"
else
	SRC_URI="https://github.com/vinceliuice/${MY_PN}/archive/${MY_PV}.tar.gz
		-> ${P}.gh.tar.gz"
	S="${WORKDIR}/${MY_PN}-${MY_PV}"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="+hardlink round"
RESTRICT="binchecks strip test"

BDEPEND="
	sys-apps/util-linux[hardlink(-)?]
"

src_prepare() {
	default

	sed -i '/gtk-update-icon-cache/d' install.sh || die
}

src_install() {
	dodir /usr/share/icons
	local -a myinstallopts=(
		--all
		--dest "${ED}/usr/share/icons"
		$(usev round '--round')
	)
	bash ./install.sh "${myinstallopts[@]}" || die "install script failed"

	if use hardlink ; then
		einfo "Linking duplicate icons... (may take a long time)"
		hardlink -pot "${ED}/usr/share/icons" || die "hardlink failed"
	fi

	# Installs broken symlink. By design, but we remove it due to QA warnings.
	find "${ED}" -xtype l -delete || die "removing broken symlinks failed"

	einstalldocs
}
