From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 27 Sep 2011 09:29:31 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 Mackerel NOR Flash USB boot fix
Message-Id: <20110927092931.29161.32785.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Always use CS0 shadow area for NOR flash instead of regular CS0
memory area on Mackerel.

When booting from CS0 NOR Flash the regular CS0 memory area is
available, but when booting via USB the MASK ROM gets mapped to
0x0 which gets in the way for the NOR Flash. Always using CS0
shadow area works well for both NOR Flash boot and USB boot.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-mackerel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-09-22 21:30:39.000000000 +0900
@@ -272,8 +272,8 @@ static struct physmap_flash_data nor_fla
 
 static struct resource nor_flash_resources[] = {
 	[0]	= {
-		.start	= 0x00000000,
-		.end	= 0x08000000 - 1,
+		.start	= 0x20000000, /* CS0 shadow instead of regular CS0 */
+		.end	= 0x28000000 - 1, /* needed by USB MASK ROM boot */
 		.flags	= IORESOURCE_MEM,
 	}
 };
