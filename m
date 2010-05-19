From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 19 May 2010 18:33:59 +0000
Subject: [PATCH 2/10 v2] SH: add DMA slaves for two SDHI controllers to sh7722
Message-Id: <Pine.LNX.4.64.1005191757430.3099@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

SuperH SDHI controllers can use DMA, add slave definitions to sh7722.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 5ea2d03..d292170 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -74,6 +74,16 @@ static const struct sh_dmae_slave_config sh7722_dmae_slaves[] = {
 		.addr		= 0xa454c094,
 		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
 		.mid_rid	= 0xb6,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
+		.addr		= 0x04ce0030,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI0_RX,
+		.addr		= 0x04ce0030,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc2,
 	},
 };
 
-- 
1.6.2.4

