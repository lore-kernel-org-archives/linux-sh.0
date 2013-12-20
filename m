From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 20 Dec 2013 14:14:23 +0000
Subject: [PATCH 0/5] arm: r8a7791: koelsch: Add USB support
Message-Id: <1387548868-20943-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

This adds USBHS device and PCI USB host support to Koelsch board.
The patches depend on the following commits:
USBHS and PCI USB host:
* https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?i=
d=C8ba8115a21226fba3211085f570b128fa271e31
* http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?id=C3e5=
d2985ef720cbbdc63546a5c545ac4450d96e
PCI USB host:
* https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3Du=
sb-next&id=103e127d1f8f985e8a662da6537ebc5e08902ee3
* https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3Du=
sb-next&id=1Ae5799ef63176cc75ec10e545cb65f620a82747
* https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=3D=
pci/host-rcar&id=FB178d8b2fab3f2a9f203c13ffe80cfd6e01bdf1

Valentine Barshak (5):
  pinctl: sh-pfc: r8a7791: Group USB PWEN and OVC pins together
  arm: shmobile: r8a7791: Add USBHS clock support
  arm: shmobile: koelsch: Add USBHS support
  arm: shmobile: r8a7791: Add PCI USB host clock support
  arm: shmobile: koelsch: Add internal PCI support

 arch/arm/mach-shmobile/board-koelsch.c | 164 +++++++++++++++++++++++++++++=
++++
 arch/arm/mach-shmobile/clock-r8a7791.c |   7 ++
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c   |  40 +++-----
 3 files changed, 183 insertions(+), 28 deletions(-)

--=20
1.8.3.1

