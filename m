From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 10 Jul 2013 11:16:47 +0000
Subject: [PATCH v4 2/2] ARM: shmobile: ape6evm: add DMA support to MMCIF
Message-Id: <Pine.LNX.4.64.1307101313220.6609@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add DMA support for MMCIF on APE6EVM, using the shdma dmaengine driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v4: extracted from "[PATCH v3 2/7] ARM: shmobile: ape6evm: add MMCIF 
support"

 arch/arm/mach-shmobile/board-ape6evm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index ccf8b04..e9e2108e 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -75,6 +75,8 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[]  /* MMCIF */
 static struct sh_mmcif_plat_data mmcif0_pdata = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.slave_id_tx	= SHDMA_SLAVE_MMCIF0_TX,
+	.slave_id_rx	= SHDMA_SLAVE_MMCIF0_RX,
 };
 
 static struct resource mmcif0_resources[] = {
-- 
1.7.2.5

