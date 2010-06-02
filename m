From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Jun 2010 00:27:46 +0000
Subject: [PATCH 3/4] sh: make sure static declaration on mach-migor
Message-Id: <w3p4ohmb7nl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-migor/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 87185de..662debe 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -181,7 +181,7 @@ static int migor_nand_flash_ready(struct mtd_info *mtd)
 	return gpio_get_value(GPIO_PTA1); /* NAND_RBn */
 }
 
-struct platform_nand_data migor_nand_flash_data = {
+static struct platform_nand_data migor_nand_flash_data = {
 	.chip = {
 		.nr_chips = 1,
 		.partitions = migor_nand_flash_partitions,
-- 
1.7.0.4

