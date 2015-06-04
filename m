From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:22:28 +0000
Subject: [PATCH 04/11] ARM: shmobile: R-Car: Shrink rcar_sysc_ch size
Message-Id: <1433442155-19492-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Shrink the individual fields in struct rcar_sysc_ch, as unsigned long or
int is overkill:
  - chan_offs contains a register offset relative to a base value
    (< 512),
  - chan_bit and isr_bit contain bit indices (0-31).

This reduces the size of each instance from 3 (4 on 64-bit) 32-bit words
to 1 32-bit word.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rcar.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar.h b/arch/arm/mach-shmobile/pm-rcar.h
index ef3a1ef628f18b00..06ebf00a6a5a78b8 100644
--- a/arch/arm/mach-shmobile/pm-rcar.h
+++ b/arch/arm/mach-shmobile/pm-rcar.h
@@ -2,9 +2,9 @@
 #define PM_RCAR_H
 
 struct rcar_sysc_ch {
-	unsigned long chan_offs;
-	unsigned int chan_bit;
-	unsigned int isr_bit;
+	u16 chan_offs;
+	u8 chan_bit;
+	u8 isr_bit;
 };
 
 int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch);
-- 
1.9.1

