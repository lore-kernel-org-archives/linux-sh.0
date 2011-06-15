From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jun 2011 06:08:28 +0000
Subject: [PATCH 2/3] sh: sh7724: Add USBHS DMAEngine support
Message-Id: <w3pk4cn62zn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/include/cpu-sh4/cpu/sh7724.h   |    8 ++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   40 ++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7724.h b/arch/sh/include/cpu-sh4/cpu/sh7724.h
index 3daef8e..cbc47e6 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7724.h
@@ -298,6 +298,14 @@ enum {
 	SHDMA_SLAVE_SCIF4_RX,
 	SHDMA_SLAVE_SCIF5_TX,
 	SHDMA_SLAVE_SCIF5_RX,
+	SHDMA_SLAVE_USB0D0_TX,
+	SHDMA_SLAVE_USB0D0_RX,
+	SHDMA_SLAVE_USB0D1_TX,
+	SHDMA_SLAVE_USB0D1_RX,
+	SHDMA_SLAVE_USB1D0_TX,
+	SHDMA_SLAVE_USB1D0_RX,
+	SHDMA_SLAVE_USB1D1_TX,
+	SHDMA_SLAVE_USB1D1_RX,
 	SHDMA_SLAVE_SDHI0_TX,
 	SHDMA_SLAVE_SDHI0_RX,
 	SHDMA_SLAVE_SDHI1_TX,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 0333fe9..134a397 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -93,6 +93,46 @@ static const struct sh_dmae_slave_config sh7724_dmae_slaves[] = {
 		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x36,
 	}, {
+		.slave_id	= SHDMA_SLAVE_USB0D0_TX,
+		.addr		= 0xA4D80100,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0x73,
+	}, {
+		.slave_id	= SHDMA_SLAVE_USB0D0_RX,
+		.addr		= 0xA4D80100,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0x73,
+	}, {
+		.slave_id	= SHDMA_SLAVE_USB0D1_TX,
+		.addr		= 0xA4D80120,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0x77,
+	}, {
+		.slave_id	= SHDMA_SLAVE_USB0D1_RX,
+		.addr		= 0xA4D80120,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0x77,
+	}, {
+		.slave_id	= SHDMA_SLAVE_USB1D0_TX,
+		.addr		= 0xA4D90100,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xab,
+	}, {
+		.slave_id	= SHDMA_SLAVE_USB1D0_RX,
+		.addr		= 0xA4D90100,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xab,
+	}, {
+		.slave_id	= SHDMA_SLAVE_USB1D1_TX,
+		.addr		= 0xA4D90120,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xaf,
+	}, {
+		.slave_id	= SHDMA_SLAVE_USB1D1_RX,
+		.addr		= 0xA4D90120,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xaf,
+	}, {
 		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
 		.addr		= 0x04ce0030,
 		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
-- 
1.7.4.1

