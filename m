From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 02:45:12 +0000
Subject: [PATCH 07/20] ARM: mach-shmobile: ap4evb: remove white space from end of line
Message-Id: <87r51f9y2y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 7283d69..f64c27f 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -201,7 +201,7 @@ static struct physmap_flash_data nor_flash_data = {
 static struct resource nor_flash_resources[] = {
 	[0]	= {
 		.start	= 0x20000000, /* CS0 shadow instead of regular CS0 */
-		.end	= 0x28000000 - 1, /* needed by USB MASK ROM boot */		
+		.end	= 0x28000000 - 1, /* needed by USB MASK ROM boot */
 		.flags	= IORESOURCE_MEM,
 	}
 };
-- 
1.7.5.4

