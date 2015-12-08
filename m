From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 08 Dec 2015 17:40:59 +0000
Subject: [PATCH] mtd: nand: Confine MTD_NAND_SH_FLCTL to SUPERH
Message-Id: <1449596459-31653-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

As of commit a521422ea4ae6128 ("ARM: shmobile: mackerel: Remove Legacy C
board code"), the Renesas SuperH FLCTL driver is no longer used on ARM
SH-Mobile SoCs. Restrict the dependencies, unless compile-testing.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 289664089cf32ce9..6c71f623a932be67 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -480,7 +480,7 @@ config MTD_NAND_MXC
 
 config MTD_NAND_SH_FLCTL
 	tristate "Support for NAND on Renesas SuperH FLCTL"
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on HAS_DMA
 	help
-- 
1.9.1

