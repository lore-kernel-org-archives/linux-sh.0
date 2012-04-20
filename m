From: Bastian Hecht <hechtb@googlemail.com>
Date: Fri, 20 Apr 2012 09:13:43 +0000
Subject: [PATCH 2/9] ARM: sh-mobile: mackerel: Add error IRQ resource
Message-Id: <1334913230-23615-3-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

Supply the platform data for the FLSTEI error IRQ.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 8758f94..1de1fb7 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -990,7 +990,11 @@ static struct resource nand_flash_resources[] = {
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
1.7.5.4

