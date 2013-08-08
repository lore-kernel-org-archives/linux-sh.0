From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 08 Aug 2013 12:03:27 +0000
Subject: [PATCH v3 1/8] ARM: shmobile: r8a7779: Rename DU device in clock lookups list
Message-Id: <1375963414-31096-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The DU device will be called rcar-du-r8a7779. Rename the clock lookup
entry accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 10340f5..21e6364 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -190,7 +190,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP320]), /* SDHI3 */
-	CLKDEV_DEV_ID("rcar-du.0", &mstp_clks[MSTP103]), /* DU */
+	CLKDEV_DEV_ID("rcar-du-r8a7779", &mstp_clks[MSTP103]), /* DU */
 };
 
 void __init r8a7779_clock_init(void)
-- 
1.8.1.5

