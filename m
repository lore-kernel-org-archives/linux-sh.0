From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 20 Dec 2013 14:13:21 +0000
Subject: [PATCH 0/3] arm: r8a7790: lager: Add USB support
Message-Id: <1387548804-20829-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

This adds USBHS device and PCI USB host support to Lager board.
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

Valentine Barshak (3):
  arm: shmobile: lager: Add USBHS support
  arm: shmobile: r8a7790: Add PCI USB host clock support
  arm: shmobile: lager: Add internal PCI support

 arch/arm/mach-shmobile/board-lager.c   | 185 +++++++++++++++++++++++++++++=
++++
 arch/arm/mach-shmobile/clock-r8a7790.c |   6 +-
 2 files changed, 190 insertions(+), 1 deletion(-)

--=20
1.8.3.1

