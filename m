From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 07 Nov 2009 10:55:56 +0000
Subject: [PATCH 2/3] sh: Use ioremap_fixmed to map the SM501 DRAM config register
Message-Id: <b79b0ed9a88b791015354768041c0b0a1643c269.1257590789.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We need to write to the DRAM config register very early and at such an
early stage ioremap() is not available. So use ioremap_fixed() to map
the register.

The reason that we are avoiding using the legacy P2 mapping is that
there will come a day when the legacy P2 mappings no longer exist.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/boards/board-sh7785lcr.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index e5a8a2f..932b8b6 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -341,8 +341,15 @@ static void __init sh7785lcr_setup(char **cmdline_p)
 	pm_power_off = sh7785lcr_power_off;
 
 	/* sm501 DRAM configuration */
-	sm501_reg = (void __iomem *)0xb3e00000 + SM501_DRAM_CONTROL;
-	writel(0x000307c2, sm501_reg);
+	sm501_reg = ioremap_fixed(SM107_REG_ADDR, SM501_DRAM_CONTROL,
+				  PAGE_KERNEL);
+	if (!sm501_reg) {
+		printk(KERN_ERR "%s: ioremap error.\n", __func__);
+		return;
+	}
+
+	writel(0x000307c2, sm501_reg + SM501_DRAM_CONTROL);
+	iounmap_fixed(sm501_reg);
 }
 
 /* Return the board specific boot mode pin configuration */
-- 
1.6.2.5

