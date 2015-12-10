From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 10 Dec 2015 15:15:59 +0000
Subject: [PATCH 0/3] ARM: shmobile: defconfig: Misc updates
Message-Id: <1449760562-26795-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

	Hi Simon, Magnus,

Here are a few updates for the shmobile defconfig.
If these are accepted, I'll send out equivalent updates for
multi_v7_defconfig.

Geert Uytterhoeven (3):
  ARM: shmobile: defconfig: Drop useless CONFIG_USB_RCAR_PHY=y
  ARM: shmobile: defconfig: Enable missing support based on DTSes
  ARM: shmobile: defconfig: Enable frame buffer console for
    armadillo800eva

 arch/arm/configs/shmobile_defconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
