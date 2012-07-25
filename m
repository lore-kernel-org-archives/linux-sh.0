From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 25 Jul 2012 07:53:21 +0000
Subject: [PATCH] sh: modify the sh_dmae_slave_config for RSPI in setup-sh7757
Message-Id: <500FA5F1.5090302@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F8FE312.2040203@renesas.com>
In-Reply-To: <4F8FE312.2040203@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Modify the sh7757_dmae1_slave to add paramters of RSPI's slave_id.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/include/cpu-sh4/cpu/sh7757.h   |    2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7757.h b/arch/sh/include/cpu-sh4/cpu/sh7757.h
index 41f9f8b..5340f3b 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7757.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7757.h
@@ -283,5 +283,7 @@ enum {
 	SHDMA_SLAVE_RIIC8_RX,
 	SHDMA_SLAVE_RIIC9_TX,
 	SHDMA_SLAVE_RIIC9_RX,
+	SHDMA_SLAVE_RSPI_TX,
+	SHDMA_SLAVE_RSPI_RX,
 };
 #endif /* __ASM_SH7757_H__ */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index a770842..4a2f357 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -216,6 +216,20 @@ static const struct sh_dmae_slave_config sh7757_dmae1_slaves[] = {
 				  TS_INDEX2VAL(XMIT_SZ_8BIT),
 		.mid_rid	= 0x42,
 	},
+	{
+		.slave_id	= SHDMA_SLAVE_RSPI_TX,
+		.addr		= 0xfe480004,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc1,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RSPI_RX,
+		.addr		= 0xfe480004,
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc2,
+	},
 };

 static const struct sh_dmae_slave_config sh7757_dmae2_slaves[] = {
-- 
1.7.1
