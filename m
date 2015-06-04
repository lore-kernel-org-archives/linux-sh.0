From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:22:32 +0000
Subject: [PATCH 08/11] ARM: shmobile: R-Car: Get rid of on_off_fn() function pointer
Message-Id: <1433442155-19492-9-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Simplify the power request code by passing an "on" flag, and picking the
right status bit and register offset in the innermost function, based on
this flag.
This allows to remove the rcar_sysc_pwr_{off,on}() helper functions, and
the function pointer through which they were called.

Make sr_bit and reg_offs unsigned while we're at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rcar.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
index 7adf9ce5fc1d1ffe..4092ad16e0a42a26 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/arch/arm/mach-shmobile/pm-rcar.c
@@ -51,11 +51,19 @@
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 
-static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch,
-				int sr_bit, int reg_offs)
+static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch, bool on)
 {
+	unsigned int sr_bit, reg_offs;
 	int k;
 
+	if (on) {
+		sr_bit = SYSCSR_PONENB;
+		reg_offs = PWRONCR_OFFS;
+	} else {
+		sr_bit = SYSCSR_POFFENB;
+		reg_offs = PWROFFCR_OFFS;
+	}
+
 	/* Wait until SYSC is ready to accept a power request */
 	for (k = 0; k < SYSCSR_RETRIES; k++) {
 		if (ioread32(rcar_sysc_base + SYSCSR) & BIT(sr_bit))
@@ -73,18 +81,7 @@ static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch,
 	return 0;
 }
 
-static int rcar_sysc_pwr_off(const struct rcar_sysc_ch *sysc_ch)
-{
-	return rcar_sysc_pwr_on_off(sysc_ch, SYSCSR_POFFENB, PWROFFCR_OFFS);
-}
-
-static int rcar_sysc_pwr_on(const struct rcar_sysc_ch *sysc_ch)
-{
-	return rcar_sysc_pwr_on_off(sysc_ch, SYSCSR_PONENB, PWRONCR_OFFS);
-}
-
-static int rcar_sysc_update(const struct rcar_sysc_ch *sysc_ch,
-			    int (*on_off_fn)(const struct rcar_sysc_ch *))
+static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 {
 	unsigned int isr_mask = BIT(sysc_ch->isr_bit);
 	unsigned int chan_mask = BIT(sysc_ch->chan_bit);
@@ -99,7 +96,7 @@ static int rcar_sysc_update(const struct rcar_sysc_ch *sysc_ch,
 
 	/* Submit power shutoff or resume request until it was accepted */
 	for (k = 0; k < PWRER_RETRIES; k++) {
-		ret = on_off_fn(sysc_ch);
+		ret = rcar_sysc_pwr_on_off(sysc_ch, on);
 		if (ret)
 			goto out;
 
@@ -138,12 +135,12 @@ static int rcar_sysc_update(const struct rcar_sysc_ch *sysc_ch,
 
 int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch)
 {
-	return rcar_sysc_update(sysc_ch, rcar_sysc_pwr_off);
+	return rcar_sysc_power(sysc_ch, false);
 }
 
 int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
 {
-	return rcar_sysc_update(sysc_ch, rcar_sysc_pwr_on);
+	return rcar_sysc_power(sysc_ch, true);
 }
 
 bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
-- 
1.9.1

