From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 30 Jun 2012 23:12:04 +0000
Subject: [PATCH] ARM: mach-shmobile: add SDHI2 to the 2.8V fixed regulator consumers on kzm9g
Message-Id: <Pine.LNX.4.64.1207010059380.24651@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The recently added SDHI2 interface to kzm9g needs power supplies for the
upcoming transition away from OCR masks, provided in platform data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Rafael, please, take this one too for 3.6. SDHI2 has just been added, so, 
we need a power regulator for it as well.

 arch/arm/mach-shmobile/board-kzm9g.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index e72ff8d..53b7ea9 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -373,11 +373,13 @@ static struct platform_device mmc_device = {
 	.resource	= sh_mmcif_resources,
 };
 
-/* Fixed 2.8V regulators to be used by SDHI0 */
+/* Fixed 2.8V regulators to be used by SDHI0 and SDHI2 */
 static struct regulator_consumer_supply fixed2v8_power_consumers[]  {
 	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
 	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.2"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.2"),
 };
 
 /* SDHI */
-- 
1.7.2.5

