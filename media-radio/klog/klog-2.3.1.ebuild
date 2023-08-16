# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Logging software for amateur radio"
HOMEPAGE="https://www.klog.xyz"

EGIT_REPO="https://github.com/ea4k/klog"

if [[ "${PV}" != "9999" ]]; then
	EGIT_REPO_URI="${EGIT_REPO}.git"
	inherit git-r3
else
	SRC_URI="${EGIT_REPO}/releases/download/v${PV}/${PN}-${PV}.tar.gz"
    KEYWORDS="~amd64"
	S="${WORKDIR}"
fi

inherit qmake-utils

# TODO: Check if this is needed lower down when setting up with tagged versions
#    S=${WORKDIR}/${PN}-${P}

#RESTRICT="network-sandbox"
LICENSE="GPL-3"
SLOT="0"
REQUIRED_USE="qt5"
IUSE="doc qt5"

RDEPEND="
        x11-libs/libX11
        dev-qt/qtcore:5
        dev-qt/qtgui:5
        dev-qt/qtdiag:5
        dev-qt/qtcharts:5
        dev-qt/qtserialport:5
        dev-qt/qtdeclarative:5
        dev-qt/qtpositioning:5
        media-libs/hamlib
        "

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/hamlib-library-path.patch"
)

#src_prepare() {
#	eapply -p0 "${FILESDIR}"...
#}

src_configure() {
#	eqmake5 PREFIX=${EPREFIX}/ ${WORKDIR}/src/src.pro
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
#einstalldocs
}

