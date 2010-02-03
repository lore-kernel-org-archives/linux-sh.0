From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Feb 2010 16:37:23 +0000
Subject: [PATCH] ASoC: fix compilation breakage in sound/soc/sh/fsi.c
Message-Id: <Pine.LNX.4.64.1002031735230.6324@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Paul Mundt <lethal@linux-sh.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

ctrl_outl() has become void at some point, which breaks compilation of fsi.c.
Make writing functions void, as their output is anyway not evaluated, and use
__raw_writel and __raw_readl instead of deprecated ctrl_outl and ctrl_inl
respectively.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

=> linux-next / 2.6.34

 sound/soc/sh/fsi.c |   40 +++++++++++++++++-----------------------
 1 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index ebf3588..3c36d24 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -120,35 +120,35 @@ struct fsi_master {
 
 
 ************************************************************************/
-static int __fsi_reg_write(u32 reg, u32 data)
+static void __fsi_reg_write(u32 reg, u32 data)
 {
 	/* valid data area is 24bit */
 	data &= 0x00ffffff;
 
-	return ctrl_outl(data, reg);
+	__raw_writel(data, reg);
 }
 
 static u32 __fsi_reg_read(u32 reg)
 {
-	return ctrl_inl(reg);
+	return __raw_readl(reg);
 }
 
-static int __fsi_reg_mask_set(u32 reg, u32 mask, u32 data)
+static void __fsi_reg_mask_set(u32 reg, u32 mask, u32 data)
 {
 	u32 val = __fsi_reg_read(reg);
 
 	val &= ~mask;
 	val |= data & mask;
 
-	return __fsi_reg_write(reg, val);
+	__fsi_reg_write(reg, val);
 }
 
-static int fsi_reg_write(struct fsi_priv *fsi, u32 reg, u32 data)
+static void fsi_reg_write(struct fsi_priv *fsi, u32 reg, u32 data)
 {
 	if (reg > REG_END)
-		return -1;
+		return;
 
-	return __fsi_reg_write((u32)(fsi->base + reg), data);
+	__fsi_reg_write((u32)(fsi->base + reg), data);
 }
 
 static u32 fsi_reg_read(struct fsi_priv *fsi, u32 reg)
@@ -159,28 +159,25 @@ static u32 fsi_reg_read(struct fsi_priv *fsi, u32 reg)
 	return __fsi_reg_read((u32)(fsi->base + reg));
 }
 
-static int fsi_reg_mask_set(struct fsi_priv *fsi, u32 reg, u32 mask, u32 data)
+static void fsi_reg_mask_set(struct fsi_priv *fsi, u32 reg, u32 mask, u32 data)
 {
 	if (reg > REG_END)
-		return -1;
+		return;
 
-	return __fsi_reg_mask_set((u32)(fsi->base + reg), mask, data);
+	__fsi_reg_mask_set((u32)(fsi->base + reg), mask, data);
 }
 
-static int fsi_master_write(struct fsi_master *master, u32 reg, u32 data)
+static void fsi_master_write(struct fsi_master *master, u32 reg, u32 data)
 {
-	int ret;
 	unsigned long flags;
 
 	if ((reg < MREG_START) ||
 	    (reg > MREG_END))
-		return -1;
+		return;
 
 	spin_lock_irqsave(&master->lock, flags);
-	ret = __fsi_reg_write((u32)(master->base + reg), data);
+	__fsi_reg_write((u32)(master->base + reg), data);
 	spin_unlock_irqrestore(&master->lock, flags);
-
-	return ret;
 }
 
 static u32 fsi_master_read(struct fsi_master *master, u32 reg)
@@ -199,21 +196,18 @@ static u32 fsi_master_read(struct fsi_master *master, u32 reg)
 	return ret;
 }
 
-static int fsi_master_mask_set(struct fsi_master *master,
+static void fsi_master_mask_set(struct fsi_master *master,
 			       u32 reg, u32 mask, u32 data)
 {
-	int ret;
 	unsigned long flags;
 
 	if ((reg < MREG_START) ||
 	    (reg > MREG_END))
-		return -1;
+		return;
 
 	spin_lock_irqsave(&master->lock, flags);
-	ret = __fsi_reg_mask_set((u32)(master->base + reg), mask, data);
+	__fsi_reg_mask_set((u32)(master->base + reg), mask, data);
 	spin_unlock_irqrestore(&master->lock, flags);
-
-	return ret;
 }
 
 /************************************************************************
-- 
1.6.2.4

