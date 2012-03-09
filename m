From: Thomas Schwinge <thomas@codesourcery.com>
Date: Fri, 09 Mar 2012 16:38:50 +0000
Subject: [PATCH 4/7] clocksource: sh_*: restore big-endian operation.
Message-Id: <1331311133-26937-4-git-send-email-thomas@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the
endianess-agnostic I/O accessor functions.

I have only tested sh_tmu on both litte-endian and big-endian sh7785lcr; I'm
changing the other two analoguously.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Cc: John Stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/sh_cmt.c  |    8 ++++----
 drivers/clocksource/sh_mtu2.c |   12 ++++++------
 drivers/clocksource/sh_tmu.c  |   12 ++++++------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index ca09bc4..157f684 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -77,10 +77,10 @@ static inline unsigned long sh_cmt_read(struct sh_cmt_priv *p, int reg_nr)
 	else {
 		offs <<= 2;
 		if ((reg_nr = CMCNT) || (reg_nr = CMCOR))
-			return ioread32(base + offs);
+			return __raw_readl(base + offs);
 	}
 
-	return ioread16(base + offs);
+	return __raw_readw(base + offs);
 }
 
 static inline void sh_cmt_write(struct sh_cmt_priv *p, int reg_nr,
@@ -101,12 +101,12 @@ static inline void sh_cmt_write(struct sh_cmt_priv *p, int reg_nr,
 	else {
 		offs <<= 2;
 		if ((reg_nr = CMCNT) || (reg_nr = CMCOR)) {
-			iowrite32(value, base + offs);
+			__raw_writel(value, base + offs);
 			return;
 		}
 	}
 
-	iowrite16(value, base + offs);
+	__raw_writew(value, base + offs);
 }
 
 static unsigned long sh_cmt_get_counter(struct sh_cmt_priv *p,
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index db8d595..f61193e 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -70,14 +70,14 @@ static inline unsigned long sh_mtu2_read(struct sh_mtu2_priv *p, int reg_nr)
 	unsigned long offs;
 
 	if (reg_nr = TSTR)
-		return ioread8(base + cfg->channel_offset);
+		return __raw_readb(base + cfg->channel_offset);
 
 	offs = mtu2_reg_offs[reg_nr];
 
 	if ((reg_nr = TCNT) || (reg_nr = TGR))
-		return ioread16(base + offs);
+		return __raw_readw(base + offs);
 	else
-		return ioread8(base + offs);
+		return __raw_readb(base + offs);
 }
 
 static inline void sh_mtu2_write(struct sh_mtu2_priv *p, int reg_nr,
@@ -88,16 +88,16 @@ static inline void sh_mtu2_write(struct sh_mtu2_priv *p, int reg_nr,
 	unsigned long offs;
 
 	if (reg_nr = TSTR) {
-		iowrite8(value, base + cfg->channel_offset);
+		__raw_writeb(value, base + cfg->channel_offset);
 		return;
 	}
 
 	offs = mtu2_reg_offs[reg_nr];
 
 	if ((reg_nr = TCNT) || (reg_nr = TGR))
-		iowrite16(value, base + offs);
+		__raw_writew(value, base + offs);
 	else
-		iowrite8(value, base + offs);
+		__raw_writeb(value, base + offs);
 }
 
 static void sh_mtu2_start_stop_ch(struct sh_mtu2_priv *p, int start)
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 079e96a..88c97f9 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -58,14 +58,14 @@ static inline unsigned long sh_tmu_read(struct sh_tmu_priv *p, int reg_nr)
 	unsigned long offs;
 
 	if (reg_nr = TSTR)
-		return ioread8(base - cfg->channel_offset);
+		return __raw_readb(base - cfg->channel_offset);
 
 	offs = reg_nr << 2;
 
 	if (reg_nr = TCR)
-		return ioread16(base + offs);
+		return __raw_readw(base + offs);
 	else
-		return ioread32(base + offs);
+		return __raw_readl(base + offs);
 }
 
 static inline void sh_tmu_write(struct sh_tmu_priv *p, int reg_nr,
@@ -76,16 +76,16 @@ static inline void sh_tmu_write(struct sh_tmu_priv *p, int reg_nr,
 	unsigned long offs;
 
 	if (reg_nr = TSTR) {
-		iowrite8(value, base - cfg->channel_offset);
+		__raw_writeb(value, base - cfg->channel_offset);
 		return;
 	}
 
 	offs = reg_nr << 2;
 
 	if (reg_nr = TCR)
-		iowrite16(value, base + offs);
+		__raw_writew(value, base + offs);
 	else
-		iowrite32(value, base + offs);
+		__raw_writel(value, base + offs);
 }
 
 static void sh_tmu_start_stop_ch(struct sh_tmu_priv *p, int start)
-- 
1.7.4.1

