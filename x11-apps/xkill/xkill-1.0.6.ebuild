# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xorg-3

DESCRIPTION="kill a client by its X resource"

KEYWORDS="~alpha amd64 arm arm64 ~hppa ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux"

RDEPEND="x11-libs/libX11
	x11-libs/libXmu"
DEPEND="${RDEPEND}
	x11-base/xorg-proto"
