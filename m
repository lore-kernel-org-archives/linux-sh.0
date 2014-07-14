From: Daniel Palmer <danieruru@gmail.com>
Date: Mon, 14 Jul 2014 03:56:55 +0000
Subject: USB doesn't work on ecovec24
Message-Id: <CAO64nm4gSsfoCTW5m5W=UTQcLYzCFdTE+paD_S3t_wP2Qsn1YA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I got one of these this morning. The kernel it has is pretty crusty so
I built a new one using the ecovec24 defconfig.
There are a few messages about not being able to get certain clocks
and this apparently breaks the USB port that the board uses to boot
from.

Wedging in a clock for it like this fixes it:

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index f579dd5..f67d8d1 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -347,6 +347,7 @@ static struct clk_lookup lookups[] = {
        CLKDEV_CON_ID("veu0", &mstp_clks[HWBLK_VEU0]),
        CLKDEV_CON_ID("vpu0", &mstp_clks[HWBLK_VPU]),
        CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[HWBLK_LCDC]),
+       CLKDEV_CON_ID("usb0", &mstp_clks[HWBLK_USB0]),
 };

I'm pretty sure that's not the right way of fixing it but it's booted
Debian from the USB stick now.
