From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 01 Mar 2012 04:25:06 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: sh7372: Add FSI DMAEngine support
Message-Id: <87linlrlr5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ei22dg7q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ei22dg7q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/sh7372.h |    2 ++
 arch/arm/mach-shmobile/setup-sh7372.c        |   10 ++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 84532f9..26bf8ad 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -457,6 +457,8 @@ enum {
 	SHDMA_SLAVE_SDHI1_TX,
 	SHDMA_SLAVE_SDHI2_RX,
 	SHDMA_SLAVE_SDHI2_TX,
+	SHDMA_SLAVE_FSIA_RX,
+	SHDMA_SLAVE_FSIA_TX,
 	SHDMA_SLAVE_MMCIF_RX,
 	SHDMA_SLAVE_MMCIF_TX,
 	SHDMA_SLAVE_USB0_TX,
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 2380389..780f638 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -433,6 +433,16 @@ static const struct sh_dmae_slave_config sh7372_dmae_slaves[] = {
 		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
 		.mid_rid	= 0xce,
 	}, {
+		.slave_id	= SHDMA_SLAVE_FSIA_TX,
+		.addr		= 0xfe1f0024,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xb1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_FSIA_RX,
+		.addr		= 0xfe1f0020,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xb2,
+	}, {
 		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
 		.addr		= 0xe6bd0034,
 		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
-- 
1.7.5.4

