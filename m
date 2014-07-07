From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 07 Jul 2014 07:54:32 +0000
Subject: [PATCH v2 07/30] ARM: shmobile: r8a73a4: add SCI clock support for DT
Message-Id: <1404719695-1634-8-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This will be used when initialising SCI devices using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/mach-shmobile/clock-r8a73a4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 0f43149..49d1397 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -574,11 +574,17 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]),
+	CLKDEV_DEV_ID("e6c40000.serial", &mstp_clks[MSTP204]),
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]),
+	CLKDEV_DEV_ID("e6c50000.serial", &mstp_clks[MSTP203]),
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP206]),
+	CLKDEV_DEV_ID("e6c20000.serial", &mstp_clks[MSTP206]),
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP207]),
+	CLKDEV_DEV_ID("e6c30000.serial", &mstp_clks[MSTP207]),
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP216]),
+	CLKDEV_DEV_ID("e6ce0000.serial", &mstp_clks[MSTP216]),
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP217]),
+	CLKDEV_DEV_ID("e6cf0000.serial", &mstp_clks[MSTP217]),
 	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP218]),
 	CLKDEV_DEV_ID("e6700020.dma-controller", &mstp_clks[MSTP218]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
-- 
2.0.0.rc2

