From: <vladimir.barinov@cogentembedded.com>
Date: Sun, 23 Feb 2014 18:00:55 +0000
Subject: [PATCH V4 0/4] ARM: shmobile: koelsch: Add USB support
Message-Id: <1393178459-14637-1-git-send-email-vladimir.barinov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, magnus.damm@gmail.com, horms@verge.net.au, gnurou@gmail.com, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, valentine.barshak@cogentembedded.com

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

These patch series add the USBHS and PCI USB support to Koelsch board

The patches depend on the following commits:

USBHS and PCI USB host:
* http://git.linuxtv.org/pinchartl/fbdev.git/commit/9770d221130e18c2d0ffe13=
cd07365d473 \
                114549
* http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=C8ba8115a2 \
                1226fba3211085f570b128fa271e31
* http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?id=C3e5=
d2985ef720c \
bbdc63546a5c545ac4450d96e PCI USB host:
* http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3Dus=
b-next&id=103 \
                e127d1f8f985e8a662da6537ebc5e08902ee3
* http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3Dus=
b-next&id=1Ae \
                5799ef63176cc75ec10e545cb65f620a82747
* http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=3Dp=
ci/host-rcar& \
id=FB178d8b2fab3f2a9f203c13ffe80cfd6e01bdf1

GPIO R-Car:
* https://lkml.org/lkml/2014/2/23/60

Changes in V4:
* folded USBHS and internal PCI USB related patches together
* added handling of ID pin from MAX3355E chip
* removed ifdefs
* added USB and PCI to koelsch_defconfig

Changes in V3:
* fixed the USB1 device name in the pinmux table;
* fixed a typo in the "Add internal PCI support" log message.

Changes in V2:
* capitalized ARM in the subject;
* rebased on top the latest devel tag;
* added pipe_type array to the usbhs platform info since it differs from th=
e default.

Valentine Barshak, Vladimir Barinov (4):
  ARM: shmobile: r8a7791: Add USBHS clock support
  ARM: shmobile: r8a7791: Add PCI USB host clock support
  ARM: shmobile: koelsch: Add USBHS and internal PCI USB support
  ARM: shmobile: koelsch: Add USB and PCI to defconfig

---
 arch/arm/configs/koelsch_defconfig     |   16 ++
 arch/arm/mach-shmobile/board-koelsch.c |  183 ++++++++++++++++++++++++++++=
+++++
 arch/arm/mach-shmobile/clock-r8a7791.c |    7 +
 3 files changed, 205 insertions(+), 1 deletion(-)
