From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Wed, 28 Mar 2012 18:14:04 +0000
Subject: [PATCH 5/5] sh: Use the plat_nand default partition parser
Message-Id: <201203281114.04557.hartleys@visionengravers.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: lethal@linux-sh.org, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Use the default partition parser, cmdlinepart, provided by the plat_nand driver.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Paul Mundt <lethal@linux-sh.org>

---

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index ff6f69c..de3e0f6 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -187,7 +187,6 @@ static struct platform_nand_data migor_nand_flash_data = {
 		.partitions = migor_nand_flash_partitions,
 		.nr_partitions = ARRAY_SIZE(migor_nand_flash_partitions),
 		.chip_delay = 20,
-		.part_probe_types = (const char *[]) { "cmdlinepart", NULL },
 	},
 	.ctrl = {
 		.dev_ready = migor_nand_flash_ready,
