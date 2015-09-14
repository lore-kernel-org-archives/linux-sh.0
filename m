From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 14 Sep 2015 12:14:25 +0000
Subject: [PATCH 03/14] sh: Remove sci_ick clock alias
Message-Id: <1442232876-27629-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh-sci driver falls back to the peripheral clock if the sci_ick
clock doesn't exist. There's thus no need to create an alias for the
peripheral clock named sci_ick.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/clock-cpg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/clock-cpg.c b/arch/sh/kernel/cpu/clock-cpg.c
index 8525a671266f..786c0769b4c3 100644
--- a/arch/sh/kernel/cpu/clock-cpg.c
+++ b/arch/sh/kernel/cpu/clock-cpg.c
@@ -63,7 +63,6 @@ int __init __deprecated cpg_clk_init(void)
 	clk_add_alias("fck", "sh-mtu2", "peripheral_clk", NULL);
 	clk_add_alias("fck", "sh-cmt-16.0", "peripheral_clk", NULL);
 	clk_add_alias("fck", "sh-cmt-32.0", "peripheral_clk", NULL);
-	clk_add_alias("sci_ick", NULL, "peripheral_clk", NULL);
 
 	return ret;
 }
-- 
2.4.6

