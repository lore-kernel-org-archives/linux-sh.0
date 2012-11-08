From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Nov 2012 03:07:02 +0000
Subject: [PATCH 0/8] ARM: shmobile: board used FSI driver's clock
Message-Id: <87625g23os.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are FSI clock change patches, and renesas_usbhs Host patch.

FSI patches try to use FSI driver's clock method instead of platform's one.
This is 2nd step of FSI DT support.

Kuninori Morimoto (8):
  1) ARM: shmobile: add fsi external clock on r8a7740
  2) ARM: shmobile: add fsi external clock sh7372
  3) ARM: shmobile: mackerel: enable DMAEngine on USB Host
  4) ARM: shmobile: use FSI driver's audio clock on armadillo800eva
  5) ARM: shmobile: use FSI driver's audio clock on mackerel
  6) ARM: shmobile: use FSI driver's audio clock on ap4evb
  7) ARM: shmobile: sh7372: remove fsidivx clock
  8) ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global

 arch/arm/mach-shmobile/board-ap4evb.c          |  139 +-----------------------
 arch/arm/mach-shmobile/board-armadillo800eva.c |   38 +------
 arch/arm/mach-shmobile/board-mackerel.c        |   74 +------------
 arch/arm/mach-shmobile/clock-r8a7740.c         |    2 +
 arch/arm/mach-shmobile/clock-sh7372.c          |   18 +--
 arch/arm/mach-shmobile/include/mach/sh7372.h   |    2 -
 6 files changed, 19 insertions(+), 254 deletions(-)

3) try to use DMAEngine on renesas_usbhs Host driver.
It based on latest USB (= felipe's) branch

git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git ::  gadget
87c2905fd80da736b8f9aa58cbc0c9cf34a11aac
(usb: renesas_usbhs: add DMAEngine support on mod_host)

Other are based on latest ASoC (= Mark's) branch

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git :: /topic/fsi
ab6f6d85210c4d0265cf48e9958c04e08595055a
(ASoC: fsi: add master clock control functions)

1)2)  are for cpu patches
3)4)5)6) are for platform patches
7)8) are for cpu patches, but depend on platform patches

-- 
1.7.9.5



Best regards
---
Kuninori Morimoto
