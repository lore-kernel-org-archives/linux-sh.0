From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:22:31 +0000
Subject: [PATCH 07/11] ARM: shmobile: R-Car: Use BIT() macro instead of open coding
Message-Id: <1433442155-19492-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rcar.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
index b1a7f2a7f7572152..7adf9ce5fc1d1ffe 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/arch/arm/mach-shmobile/pm-rcar.c
@@ -58,7 +58,7 @@ static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch,
 
 	/* Wait until SYSC is ready to accept a power request */
 	for (k = 0; k < SYSCSR_RETRIES; k++) {
-		if (ioread32(rcar_sysc_base + SYSCSR) & (1 << sr_bit))
+		if (ioread32(rcar_sysc_base + SYSCSR) & BIT(sr_bit))
 			break;
 		udelay(SYSCSR_DELAY_US);
 	}
@@ -67,7 +67,7 @@ static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch,
 		return -EAGAIN;
 
 	/* Submit power shutoff or power resume request */
-	iowrite32(1 << sysc_ch->chan_bit,
+	iowrite32(BIT(sysc_ch->chan_bit),
 		  rcar_sysc_base + sysc_ch->chan_offs + reg_offs);
 
 	return 0;
@@ -86,8 +86,8 @@ static int rcar_sysc_pwr_on(const struct rcar_sysc_ch *sysc_ch)
 static int rcar_sysc_update(const struct rcar_sysc_ch *sysc_ch,
 			    int (*on_off_fn)(const struct rcar_sysc_ch *))
 {
-	unsigned int isr_mask = 1 << sysc_ch->isr_bit;
-	unsigned int chan_mask = 1 << sysc_ch->chan_bit;
+	unsigned int isr_mask = BIT(sysc_ch->isr_bit);
+	unsigned int chan_mask = BIT(sysc_ch->chan_bit);
 	unsigned int status;
 	unsigned long flags;
 	int ret = 0;
@@ -151,7 +151,7 @@ bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
 	unsigned int st;
 
 	st = ioread32(rcar_sysc_base + sysc_ch->chan_offs + PWRSR_OFFS);
-	if (st & (1 << sysc_ch->chan_bit))
+	if (st & BIT(sysc_ch->chan_bit))
 		return true;
 
 	return false;
-- 
1.9.1

