From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:22:30 +0000
Subject: [PATCH 06/11] ARM: shmobile: R-Car: Make struct rcar_sysc_ch * parameters const
Message-Id: <1433442155-19492-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The passed struct rcar_sysc_ch is never modified, so it can be const.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rcar.c | 16 ++++++++--------
 arch/arm/mach-shmobile/pm-rcar.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
index a5e4c3a88ec4f127..b1a7f2a7f7572152 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/arch/arm/mach-shmobile/pm-rcar.c
@@ -51,7 +51,7 @@
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 
-static int rcar_sysc_pwr_on_off(struct rcar_sysc_ch *sysc_ch,
+static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch,
 				int sr_bit, int reg_offs)
 {
 	int k;
@@ -73,18 +73,18 @@ static int rcar_sysc_pwr_on_off(struct rcar_sysc_ch *sysc_ch,
 	return 0;
 }
 
-static int rcar_sysc_pwr_off(struct rcar_sysc_ch *sysc_ch)
+static int rcar_sysc_pwr_off(const struct rcar_sysc_ch *sysc_ch)
 {
 	return rcar_sysc_pwr_on_off(sysc_ch, SYSCSR_POFFENB, PWROFFCR_OFFS);
 }
 
-static int rcar_sysc_pwr_on(struct rcar_sysc_ch *sysc_ch)
+static int rcar_sysc_pwr_on(const struct rcar_sysc_ch *sysc_ch)
 {
 	return rcar_sysc_pwr_on_off(sysc_ch, SYSCSR_PONENB, PWRONCR_OFFS);
 }
 
-static int rcar_sysc_update(struct rcar_sysc_ch *sysc_ch,
-			    int (*on_off_fn)(struct rcar_sysc_ch *))
+static int rcar_sysc_update(const struct rcar_sysc_ch *sysc_ch,
+			    int (*on_off_fn)(const struct rcar_sysc_ch *))
 {
 	unsigned int isr_mask = 1 << sysc_ch->isr_bit;
 	unsigned int chan_mask = 1 << sysc_ch->chan_bit;
@@ -136,17 +136,17 @@ static int rcar_sysc_update(struct rcar_sysc_ch *sysc_ch,
 	return ret;
 }
 
-int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch)
+int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch)
 {
 	return rcar_sysc_update(sysc_ch, rcar_sysc_pwr_off);
 }
 
-int rcar_sysc_power_up(struct rcar_sysc_ch *sysc_ch)
+int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
 {
 	return rcar_sysc_update(sysc_ch, rcar_sysc_pwr_on);
 }
 
-bool rcar_sysc_power_is_off(struct rcar_sysc_ch *sysc_ch)
+bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
 {
 	unsigned int st;
 
diff --git a/arch/arm/mach-shmobile/pm-rcar.h b/arch/arm/mach-shmobile/pm-rcar.h
index 06ebf00a6a5a78b8..1b901db4a24c4633 100644
--- a/arch/arm/mach-shmobile/pm-rcar.h
+++ b/arch/arm/mach-shmobile/pm-rcar.h
@@ -7,9 +7,9 @@ struct rcar_sysc_ch {
 	u8 isr_bit;
 };
 
-int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch);
-int rcar_sysc_power_up(struct rcar_sysc_ch *sysc_ch);
-bool rcar_sysc_power_is_off(struct rcar_sysc_ch *sysc_ch);
+int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
+int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
+bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch);
 void __iomem *rcar_sysc_init(phys_addr_t base);
 
 #endif /* PM_RCAR_H */
-- 
1.9.1

