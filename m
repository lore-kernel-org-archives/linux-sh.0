From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 11 Dec 2015 10:45:24 +0000
Subject: [PATCH 0/3] ARM: multi_v7_defconfig: Misc shmobile updates
Message-Id: <1449830727-325-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

	Hi Simon, Magnus, arm-soc,

Here are a few updates for the ARM multi_v7 defconfig.
They are equivalent to the updates for shmobile_defconfig that have just
been accepted by Simon.

This is against renesas-devel-20151211v2-v4.4-rc4.
There's a small conflict when applying to arm-soc/for-next, so Simon's
tree looks like the best way forward.

Thanks!

Geert Uytterhoeven (3):
  ARM: multi_v7_defconfig: Drop useless CONFIG_USB_RCAR_PHY=y
  ARM: multi_v7_defconfig: Enable missing Renesas ARM support based on
    DTSes
  ARM: multi_v7_defconfig: Enable frame buffer console for
    armadillo800eva

 arch/arm/configs/multi_v7_defconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
