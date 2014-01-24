From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 24 Jan 2014 22:28:46 +0000
Subject: [PATCH V3 0/3] ARM: shmobile: lager: Add USB support
Message-Id: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

The first patch adds USBHS device and the rest add PCI USB host support to =
Lager board.
The patches depend on the following commits:
USBHS and PCI USB host:
* http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=C8ba8115a21226fba3211085f570b128fa271e31
* http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?id=C3e5=
d2985ef720cbbdc63546a5c545ac4450d96e
PCI USB host:
* http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3Dus=
b-next&id=103e127d1f8f985e8a662da6537ebc5e08902ee3
* http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3Dus=
b-next&id=1Ae5799ef63176cc75ec10e545cb65f620a82747
* http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=3Dp=
ci/host-rcar&id=FB178d8b2fab3f2a9f203c13ffe80cfd6e01bdf1

Changes in V3:
* fixed USB1 and USB2 device names in the pinmux table.
* fixed a typo in the "Add internal PCI support" log message.

Changes in V2:
* capitalized ARM in the subject;
* rebased on top the latest devel tag;
* added pipe_type array to the usbhs platform info since it differs from th=
e default.

Valentine Barshak (3):
  ARM: shmobile: lager: Add USBHS support
  ARM: shmobile: r8a7790: Add PCI USB host clock support
  ARM: shmobile: lager: Add internal PCI support

 arch/arm/mach-shmobile/board-lager.c   | 206 +++++++++++++++++++++++++++++=
++++
 arch/arm/mach-shmobile/clock-r8a7790.c |   6 +-
 2 files changed, 211 insertions(+), 1 deletion(-)

--=20
1.8.3.1

