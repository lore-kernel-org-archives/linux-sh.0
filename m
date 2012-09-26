From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 26 Sep 2012 09:05:06 +0000
Subject: [PATCH 3/3] mtd: sh_flctl: Add sh7372 device tree config
Message-Id: <1348650306-15492-3-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1348650306-15492-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1348650306-15492-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Include the configuration data to set up FLCTL via device tree probing
for the SoC sh7372.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 472c27e..b8b1d52 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -1030,7 +1030,15 @@ struct flctl_soc_config {
 	unsigned use_holden:1;
 };
 
+static struct flctl_soc_config flctl_sh7372_config = {
+	.flcmncr_val = CLK_16B_12L_4H | TYPESEL_SET | SHBUSSEL,
+	.has_hwecc = 1,
+	.use_holden = 1,
+};
+
 static const struct of_device_id of_flctl_match[] = {
+	{ .compatible = "renesas,shmobile-flctl-sh7372",
+				.data = &flctl_sh7372_config },
 	{},
 };
 MODULE_DEVICE_TABLE(of, of_flctl_match);
-- 
1.7.5.4

