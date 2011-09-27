From: Bastian Hecht <hechtb@googlemail.com>
Date: Tue, 27 Sep 2011 11:23:04 +0000
Subject: [PATCH] ARM: sh7372 ap4evb NOR Flash USB boot fix
Message-Id: <alpine.DEB.2.02.1109271309040.4011@ipanema>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Always use CS0 shadow area for NOR flash instead of regular CS0
memory area on ap4evb.

When booting from CS0 NOR Flash the regular CS0 memory area is
available, but when booting via USB the MASK ROM gets mapped to
0x0 which gets in the way for the NOR Flash. Always using CS0
shadow area works well for both NOR Flash boot and USB boot.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 1d9080c..3b3cd0c 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -198,8 +198,8 @@ static struct physmap_flash_data nor_flash_data = {
 
 static struct resource nor_flash_resources[] = {
 	[0]	= {
-		.start	= 0x00000000,
-		.end	= 0x08000000 - 1,
+		.start	= 0x20000000, /* CS0 shadow instead of regular CS0 */
+		.end	= 0x28000000 - 1, /* needed by USB MASK ROM boot */		
 		.flags	= IORESOURCE_MEM,
 	}
 };
