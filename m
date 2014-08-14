From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 14 Aug 2014 16:57:21 +0000
Subject: [PATCH 0/7] ARM: shmobile: defconfigs: Enable missing hardware support
Message-Id: <1408035448-8811-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series enables missing hardware support in the various shmobile
defconfigs, based on the DTSes.

This was done with the help of an experimental script to derive
CONFIG-options from a DTS or DTB, with some manual work to handle the
script's deficiencies.

Shmobile_defconfig and koelsch_defconfig have been booted successfully
on r8a7791/koelsch.

Geert Uytterhoeven (7):
  ARM: shmobile: shmobile_defconfig: Enable missing hardware support
  ARM: shmobile: ape6evm_defconfig: Enable missing hardware support
  ARM: shmobile: bockw_defconfig: Enable missing hardware support
  ARM: shmobile: koelsch_defconfig: Enable missing hardware support
  ARM: shmobile: kzm9g_defconfig: Enable missing hardware support
  ARM: shmobile: lager_defconfig: Enable missing hardware support
  ARM: shmobile: marzen_defconfig: Enable missing hardware support

 arch/arm/configs/ape6evm_defconfig  |  9 ++++++++-
 arch/arm/configs/bockw_defconfig    |  2 ++
 arch/arm/configs/koelsch_defconfig  | 17 +++++++++++++++++
 arch/arm/configs/kzm9g_defconfig    |  1 +
 arch/arm/configs/lager_defconfig    |  8 +++++++-
 arch/arm/configs/marzen_defconfig   |  1 +
 arch/arm/configs/shmobile_defconfig |  2 ++
 7 files changed, 38 insertions(+), 2 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
