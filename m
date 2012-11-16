From: Bastian Hecht <hechtb@gmail.com>
Date: Fri, 16 Nov 2012 10:36:11 +0000
Subject: [PATCH v2] ARM: shmobile: mackerel: Add FLCTL IRQ resource
Message-Id: <1353062171-20589-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since commit 3c7ea4eccfd2e the sh_flctl driver requires the error IRQ line to
signal failed transactions between the flash controller and the NAND chip.
This information is mandatory - else the driver refuses to start up. We
provide it here for the board mackerel.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
v2: extended commit message

 arch/arm/mach-shmobile/board-mackerel.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 0c27c81..66ec616 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1018,7 +1018,11 @@ static struct resource nand_flash_resources[] = {
 		.start	= 0xe6a30000,
 		.end	= 0xe6a3009b,
 		.flags	= IORESOURCE_MEM,
-	}
+	},
+	[1] = {
+		.start	= evt2irq(0x0d80), /* flstei: status error irq */
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 static struct sh_flctl_platform_data nand_flash_data = {
-- 
1.7.9.5

