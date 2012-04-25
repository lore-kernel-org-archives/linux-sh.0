From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 25 Apr 2012 14:03:38 +0000
Subject: [PATCH v2 10/10] ARM: sh-mobile: mackerel: Use hardware error correction
Message-Id: <1335362618-4559-11-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

Use the built-in hardware error code correction of the sh_flctl.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 1de1fb7..f8289f4 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1003,6 +1003,7 @@ static struct sh_flctl_platform_data nand_flash_data = {
 	.flcmncr_val	= CLK_16B_12L_4H | TYPESEL_SET
 			| SHBUSSEL | SEL_16BIT | SNAND_E,
 	.use_holden	= 1,
+	.has_hwecc	= 1,
 };
 
 static struct platform_device nand_flash_device = {
-- 
1.7.5.4

