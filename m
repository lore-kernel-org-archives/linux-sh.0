From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:14:28 +0000
Subject: [PATCH] sh: use arch_flags for sh_mobile mstpcr clock bits
Message-Id: <20081031111428.2964.51168.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Use arch_flags to keep track of register and flag number.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   72 +++++++++++++-------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

--- 0002/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-10-30 19:10:54.000000000 +0900
@@ -567,12 +567,30 @@ static struct clk sh7722_video_clock = {
 	.ops = &sh7722_video_clk_ops,
 };
 
-static int sh7722_mstpcr_start_stop(struct clk *clk, unsigned long reg,
-				    int enable)
+#define MSTPCR_ARCH_FLAGS(reg, bit) (((reg) << 8) | (bit))
+#define MSTPCR_ARCH_FLAGS_REG(value) ((value) >> 8)
+#define MSTPCR_ARCH_FLAGS_BIT(value) ((value) & 0xff)
+
+static int sh7722_mstpcr_start_stop(struct clk *clk, int enable)
 {
-	unsigned long bit = clk->arch_flags;
+	unsigned long bit = MSTPCR_ARCH_FLAGS_BIT(clk->arch_flags);
+	unsigned long reg;
 	unsigned long r;
 
+	switch(MSTPCR_ARCH_FLAGS_REG(clk->arch_flags)) {
+	case 0:
+		reg = MSTPCR0;
+		break;
+	case 1:
+		reg = MSTPCR1;
+		break;
+	case 2:
+		reg = MSTPCR2;
+		break;
+	default:
+		return -EINVAL;
+	}  
+
 	r = ctrl_inl(reg);
 
 	if (enable)
@@ -584,56 +602,26 @@ static int sh7722_mstpcr_start_stop(stru
 	return 0;
 }
 
-static void sh7722_mstpcr0_enable(struct clk *clk)
-{
-	sh7722_mstpcr_start_stop(clk, MSTPCR0, 1);
-}
-
-static void sh7722_mstpcr0_disable(struct clk *clk)
-{
-	sh7722_mstpcr_start_stop(clk, MSTPCR0, 0);
-}
-
-static void sh7722_mstpcr1_enable(struct clk *clk)
-{
-	sh7722_mstpcr_start_stop(clk, MSTPCR1, 1);
-}
-
-static void sh7722_mstpcr1_disable(struct clk *clk)
-{
-	sh7722_mstpcr_start_stop(clk, MSTPCR1, 0);
-}
-
-static void sh7722_mstpcr2_enable(struct clk *clk)
+static void sh7722_mstpcr_enable(struct clk *clk)
 {
-	sh7722_mstpcr_start_stop(clk, MSTPCR2, 1);
+	sh7722_mstpcr_start_stop(clk, 1);
 }
 
-static void sh7722_mstpcr2_disable(struct clk *clk)
+static void sh7722_mstpcr_disable(struct clk *clk)
 {
-	sh7722_mstpcr_start_stop(clk, MSTPCR2, 0);
+	sh7722_mstpcr_start_stop(clk, 0);
 }
 
-static struct clk_ops sh7722_mstpcr0_clk_ops = {
-	.enable = sh7722_mstpcr0_enable,
-	.disable = sh7722_mstpcr0_disable,
-};
-
-static struct clk_ops sh7722_mstpcr1_clk_ops = {
-	.enable = sh7722_mstpcr1_enable,
-	.disable = sh7722_mstpcr1_disable,
-};
-
-static struct clk_ops sh7722_mstpcr2_clk_ops = {
-	.enable = sh7722_mstpcr2_enable,
-	.disable = sh7722_mstpcr2_disable,
+static struct clk_ops sh7722_mstpcr_clk_ops = {
+	.enable = sh7722_mstpcr_enable,
+	.disable = sh7722_mstpcr_disable,
 };
 
 #define DECLARE_MSTPCRN(regnr, bitnr, bitstr)		\
 {							\
 	.name = "mstp" __stringify(regnr) bitstr,	\
-	.arch_flags = bitnr,				\
-	.ops = &sh7722_mstpcr ## regnr ## _clk_ops,	\
+	.arch_flags = MSTPCR_ARCH_FLAGS(regnr, bitnr),	\
+	.ops = &sh7722_mstpcr_clk_ops,	\
 }
 
 #define DECLARE_MSTPCR(regnr) \
