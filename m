From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Oct 2010 07:39:18 +0000
Subject: [PATCH] ARM: shmobile: make AP4EVB MMCIF resource string consistent
Message-Id: <20101013073918.19773.79541.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Just use MMCIF as name to match the sh7372 data sheet.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ap4evb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0003/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2010-10-13 15:45:51.000000000 +0900
@@ -237,7 +237,7 @@ static struct platform_device smc911x_de
 /* SH_MMCIF */
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
-		.name	= "SH_MMCIF",
+		.name	= "MMCIF",
 		.start	= 0xE6BD0000,
 		.end	= 0xE6BD00FF,
 		.flags	= IORESOURCE_MEM,
