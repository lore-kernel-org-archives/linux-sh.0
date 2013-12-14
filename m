From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 14 Dec 2013 15:25:41 +0000
Subject: [PATCH v5 17/17] ARM: shmobile: r8a7791: Remove legacy clock aliases for DT devices
Message-Id: <1387034741-3852-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that the r8a7791 DT platforms use the common clock framework,
there's no need to manually create clock aliases for devices
instantiated through DT, as those devices will reference their clocks
directly in the device tree. Remove those aliases.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7791.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index f546126..ac2bc05 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -192,7 +192,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.13", &mstp_clks[MSTP1106]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.14", &mstp_clks[MSTP1107]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
-	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("r8a7791-ether", &mstp_clks[MSTP813]), /* Ether */
 };
-- 
1.8.3.2

