From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Aug 2013 01:34:37 +0000
Subject: [PATCH 4/4] ARM: shmobile: lager: add missing __initdata
Message-Id: <87r4ec98ph.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds missing __initdata to driver data/resource
which are used from platform_device_register_xxx()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-lager.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 3a1a6fd..aa8be24 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -82,11 +82,11 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[]  };
 
 /* MMCIF */
-static struct sh_mmcif_plat_data mmcif1_pdata = {
+static struct sh_mmcif_plat_data mmcif1_pdata __initdata = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
 };
 
-static struct resource mmcif1_resources[] = {
+static struct resource mmcif1_resources[] __initdata = {
 	DEFINE_RES_MEM_NAMED(0xee220000, 0x80, "MMCIF1"),
 	DEFINE_RES_IRQ(gic_spi(170)),
 };
-- 
1.7.9.5

