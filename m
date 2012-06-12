From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2012 09:38:20 +0000
Subject: [PATCH 15/27 v2] ARM: shmobile: r8a7740: add DMAEngine support for SDHI
Message-Id: <87lijsx43b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current shdmac can support SDHI DMAC on r8a7740.
This support reduce CPU duty when SDHI access.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Simon Horman <horms@verge.net.au>
---
v1 -> v2

 - no change

 arch/arm/mach-shmobile/include/mach/r8a7740.h |    6 +++++
 arch/arm/mach-shmobile/setup-r8a7740.c        |   30 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index f71507b..0f14ce8 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -591,6 +591,12 @@ enum {
 /* DMA slave IDs */
 enum {
 	SHDMA_SLAVE_INVALID,
+	SHDMA_SLAVE_SDHI0_RX,
+	SHDMA_SLAVE_SDHI0_TX,
+	SHDMA_SLAVE_SDHI1_RX,
+	SHDMA_SLAVE_SDHI1_TX,
+	SHDMA_SLAVE_SDHI2_RX,
+	SHDMA_SLAVE_SDHI2_TX,
 	SHDMA_SLAVE_FSIA_RX,
 	SHDMA_SLAVE_FSIA_TX,
 	SHDMA_SLAVE_FSIB_TX,
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 37fa3e7..85aaf8e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -282,6 +282,36 @@ static struct platform_device *r8a7740_early_devices[] __initdata = {
 /* DMA */
 static const struct sh_dmae_slave_config r8a7740_dmae_slaves[] = {
 	{
+		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
+		.addr		= 0xe6850030,
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI0_RX,
+		.addr		= 0xe6850030,
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc2,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI1_TX,
+		.addr		= 0xe6860030,
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc9,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI1_RX,
+		.addr		= 0xe6860030,
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xca,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI2_TX,
+		.addr		= 0xe6870030,
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xcd,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI2_RX,
+		.addr		= 0xe6870030,
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xce,
+	}, {
 		.slave_id	= SHDMA_SLAVE_FSIA_TX,
 		.addr		= 0xfe1f0024,
 		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
-- 
1.7.5.4

