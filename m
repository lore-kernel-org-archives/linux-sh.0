From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 29 Jun 2011 04:23:42 +0000
Subject: [PATCH] sh: fix the value of sh_dmae_slave_config in setup-sh7757
Message-Id: <4E0AA8CE.1020205@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix the value of chcr for SCIF[2-4]_RX and RIIC[0-9]_RX and
the value of mid_rid for some RIIC.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 717a76b..6eba96b 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -183,7 +183,7 @@ static const struct sh_dmae_slave_config sh7757_dmae1_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_SCIF2_RX,
 		.addr		= 0x1f4b0014,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x22,
 	},
@@ -197,7 +197,7 @@ static const struct sh_dmae_slave_config sh7757_dmae1_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_SCIF3_RX,
 		.addr		= 0x1f4c0014,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x2a,
 	},
@@ -211,7 +211,7 @@ static const struct sh_dmae_slave_config sh7757_dmae1_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_SCIF4_RX,
 		.addr		= 0x1f4d0014,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x42,
 	},
@@ -228,7 +228,7 @@ static const struct sh_dmae_slave_config sh7757_dmae2_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_RIIC0_RX,
 		.addr		= 0x1e500013,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x22,
 	},
@@ -242,7 +242,7 @@ static const struct sh_dmae_slave_config sh7757_dmae2_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_RIIC1_RX,
 		.addr		= 0x1e510013,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x2a,
 	},
@@ -256,7 +256,7 @@ static const struct sh_dmae_slave_config sh7757_dmae2_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_RIIC2_RX,
 		.addr		= 0x1e520013,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0xa2,
 	},
@@ -265,12 +265,12 @@ static const struct sh_dmae_slave_config sh7757_dmae2_slaves[] = {
 		.addr		= 0x1e530012,
 		.chcr		= SM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
-		.mid_rid	= 0xab,
+		.mid_rid	= 0xa9,
 	},
 	{
 		.slave_id	= SHDMA_SLAVE_RIIC3_RX,
 		.addr		= 0x1e530013,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0xaf,
 	},
@@ -279,14 +279,14 @@ static const struct sh_dmae_slave_config sh7757_dmae2_slaves[] = {
 		.addr		= 0x1e540012,
 		.chcr		= SM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
-		.mid_rid	= 0xc1,
+		.mid_rid	= 0xc5,
 	},
 	{
 		.slave_id	= SHDMA_SLAVE_RIIC4_RX,
 		.addr		= 0x1e540013,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
-		.mid_rid	= 0xc2,
+		.mid_rid	= 0xc6,
 	},
 };

@@ -301,7 +301,7 @@ static const struct sh_dmae_slave_config sh7757_dmae3_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_RIIC5_RX,
 		.addr		= 0x1e550013,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x22,
 	},
@@ -315,7 +315,7 @@ static const struct sh_dmae_slave_config sh7757_dmae3_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_RIIC6_RX,
 		.addr		= 0x1e560013,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x2a,
 	},
@@ -329,7 +329,7 @@ static const struct sh_dmae_slave_config sh7757_dmae3_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_RIIC7_RX,
 		.addr		= 0x1e570013,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x42,
 	},
@@ -343,7 +343,7 @@ static const struct sh_dmae_slave_config sh7757_dmae3_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_RIIC8_RX,
 		.addr		= 0x1e580013,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x46,
 	},
@@ -357,7 +357,7 @@ static const struct sh_dmae_slave_config sh7757_dmae3_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_RIIC9_RX,
 		.addr		= 0x1e590013,
-		.chcr		= SM_INC | 0x800 | 0x40000000 |
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x52,
 	},
-- 
1.7.1
