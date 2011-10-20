From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Oct 2011 03:02:08 +0000
Subject: [PATCH 3/5] ARM: mach-shmobile: bonito: fixup fpga_write()
Message-Id: <87d3ds2wnn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

mask of fpga_write() was a puzzling parameter.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bonito.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index 3a91e9c..64eea4b 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -88,13 +88,9 @@ static u16 fpga_read(u32 offset)
 	return __raw_readw(0xf0003000 + offset);
 }
 
-static void fpga_write(u32 offset, u16 val, u16 mask)
+static void fpga_write(u32 offset, u16 val)
 {
-	u16 tmp;
-
-	tmp = fpga_read(offset);
-	tmp = (tmp & ~mask) | (val & mask);
-	__raw_writew(tmp, 0xf0003000 + offset);
+	__raw_writew(val, 0xf0003000 + offset);
 }
 
 /*
@@ -372,7 +368,7 @@ static void __init bonito_init(void)
 			gpio_direction_output(GPIO_PORT61, 1);
 
 			/* backlight on */
-			fpga_write(LCDCR, 1, 1);
+			fpga_write(LCDCR, 1);
 
 			/*  drivability Max */
 			__raw_writew(0x00FF , VCCQ1LCDCR);
-- 
1.7.4.1

