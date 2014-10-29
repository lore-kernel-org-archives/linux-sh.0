From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Oct 2014 14:28:35 +0000
Subject: [PATCH 0/3] ARM: shmobile: koelsch: Removal cleanups
Message-Id: <1414592918-25138-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon, Magnus,

This patch series does some cleanups after the removal of koelsch-legacy
support.

Thanks for applying!

Geert Uytterhoeven (3):
  MAINTAINERS: Remove reference to shmobile / koelsch_defconfig
  ARM: dts: koelsch: Stop building r8a7791-koelsch.dtb in legacy builds
  ARM: shmobile: koelsch dts: Drop console= bootargs parameter

 MAINTAINERS                           | 1 -
 arch/arm/boot/dts/Makefile            | 1 -
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
