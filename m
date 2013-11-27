From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 01:18:31 +0000
Subject: [PATCH 09/15] mtd: sh_flctl: Enable driver compilation with COMPILE_TEST
Message-Id: <1385515117-23664-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This helps increasing build testing coverage.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 93ae6a6..cb1f2ec 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -458,7 +458,7 @@ config MTD_NAND_MXC
 
 config MTD_NAND_SH_FLCTL
 	tristate "Support for NAND on Renesas SuperH FLCTL"
-	depends on SUPERH || ARCH_SHMOBILE
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  Several Renesas SuperH CPU has FLCTL. This option enables support
 	  for NAND Flash using FLCTL.
-- 
1.8.3.2

