From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 05 Jan 2012 05:08:03 +0000
Subject: [PATCH] sh: modify clock-sh7757 for renesas_usbhs
Message-Id: <4F053033.5050805@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The renesas_usbhs driver doesn't use the clk functions. So, even if we
adds "CLKDEV_DEV_ID("renesas_usbhs.0", ...)" only, we cannot use the USB
controller because clk_late_init() will disable the clock by "usb0".
So, the patch also removes the "CLKDEV_CON_ID("usb0", ...)".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index 19222da..0fbff14 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -129,7 +129,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP110]),

 	CLKDEV_CON_ID("usb_fck", &mstp_clks[MSTP103]),
-	CLKDEV_CON_ID("usb0", &mstp_clks[MSTP102]),
+	CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[MSTP102]),
 	CLKDEV_CON_ID("mmc0", &mstp_clks[MSTP220]),
 };

-- 
1.7.1
