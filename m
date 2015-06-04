From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:22:29 +0000
Subject: [PATCH 05/11] ARM: shmobile: R-Car: Break infinite loop
Message-Id: <1433442155-19492-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

rcar_sysc_update() loops (with interrupts disabled and while holding a
spinlock) until submitting a power shutoff or resume request fails, or
until the submitted request was accepted.
If none of these conditions becomes true, this forms an infinite loop.

Put a limit on the maximum number of loop iterations, and add a small
delay to each iteration, to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
On r8a7791, the loop is always terminated during the first iteration.

 arch/arm/mach-shmobile/pm-rcar.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
index 56ea82a851cb96f7..a5e4c3a88ec4f127 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/arch/arm/mach-shmobile/pm-rcar.c
@@ -42,6 +42,9 @@
 #define SYSCSR_RETRIES		100
 #define SYSCSR_DELAY_US		1
 
+#define PWRER_RETRIES		100
+#define PWRER_DELAY_US		1
+
 #define SYSCISR_RETRIES		1000
 #define SYSCISR_DELAY_US	1
 
@@ -95,14 +98,23 @@ static int rcar_sysc_update(struct rcar_sysc_ch *sysc_ch,
 	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
 
 	/* Submit power shutoff or resume request until it was accepted */
-	do {
+	for (k = 0; k < PWRER_RETRIES; k++) {
 		ret = on_off_fn(sysc_ch);
 		if (ret)
 			goto out;
 
 		status = ioread32(rcar_sysc_base +
 				  sysc_ch->chan_offs + PWRER_OFFS);
-	} while (status & chan_mask);
+		if (!(status & chan_mask))
+			break;
+
+		udelay(PWRER_DELAY_US);
+	}
+
+	if (k = PWRER_RETRIES) {
+		ret = -EIO;
+		goto out;
+	}
 
 	/* Wait until the power shutoff or resume request has completed * */
 	for (k = 0; k < SYSCISR_RETRIES; k++) {
-- 
1.9.1

