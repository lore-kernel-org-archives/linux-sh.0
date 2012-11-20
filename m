From: Bastian Hecht <hechtb@gmail.com>
Date: Tue, 20 Nov 2012 00:05:00 +0000
Subject: [PATCH] ARM: shmobile: mackerel: Add FLCTL IRQ resource
Message-Id: <1353369900-3384-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1352803609-16669-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1352803609-16669-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since commit 3c7ea4e (mtd: sh_flctl: Add support for error IRQ)
the sh_flctl driver requires the error IRQ line to signal failed
transactions between the flash controller and the NAND chip.
This information is mandatory - else the driver refuses to start
up. We provide it here for the board mackerel.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
v1: extended commit
v2: added commit message of referenced patch

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

