From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Feb 2010 10:01:22 +0000
Subject: [PATCH] mtd: enable sh_flctl on SH-Mobile ARM
Message-Id: <20100219100122.6122.78528.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: dwmw2@infradead.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the Kconfig entry for the sh_flctl driver to
enable build on SH-Mobile ARM platforms.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies on top of the other FLCTL changes in the sh-2.6 git tree.

 drivers/mtd/nand/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/mtd/nand/Kconfig
+++ work/drivers/mtd/nand/Kconfig	2010-02-19 18:55:44.000000000 +0900
@@ -457,7 +457,7 @@ config MTD_NAND_NOMADIK
 
 config MTD_NAND_SH_FLCTL
 	tristate "Support for NAND on Renesas SuperH FLCTL"
-	depends on MTD_NAND && SUPERH
+	depends on MTD_NAND && (SUPERH || ARCH_SHMOBILE)
 	help
 	  Several Renesas SuperH CPU has FLCTL. This option enables support
 	  for NAND Flash using FLCTL.
