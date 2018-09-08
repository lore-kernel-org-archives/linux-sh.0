From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 08 Sep 2018 20:54:05 +0000
Subject: [PATCH v3] clocksource: sh_cmt: fixup for 64-bit machines
Message-Id: <46a8a01b-e849-6d62-3c61-fbae48f34e58@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-renesas-soc@vger.kernel.org
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>, linux-sh@vger.kernel.org

When trying to use CMT for clockevents on R-Car gen3 SoCs, I noticed
that 'max_delta_ns' for the broadcast timer (CMT) was shown as 1000 in
/proc/timer_list. It turned out that when calculating it, the driver did
1 << 32 (causing what I think was undefined behavior) resulting in a zero
delta, later clamped to 1000 by cev_delta2ns(). The root cause turned out
to be that the driver abused *unsigned long* for the CMT register values
(which are 16/32-bit), so that the calculation of 'ch->max_match_value'
in sh_cmt_setup_channel() used the wrong branch. Using more proper 'u32'
instead fixed 'max_delta_ns' and even fixed the switching an active
clocksource to CMT (which caused the system to turn non-interactive
before).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'tip.git' repo's 'timers/core' branch.
The CMT driver wasn't ever used on SH64; on R-Car gen3 (ARM64) I'm only
enabling building of this driver now, so not sure how urgent is this...

Changes in version 3:
- made the 'overflow_bit' and 'clear_bits' members of 'struct sh_cmt_info'
  'u32';
- made the 2nd parameter of sh_cmt_write_cmstr() 'u32';
- made the result, the 2nd parameter, and 'o{1|2}' local variables of
  sh_cmt_get_counter() 'u32';
- made the 'has_wrapped' local variables 'u32' in sh_cmt_clocksource_read()
  and sh_cmt_clock_event_program_verify();
- fixed a typo in the patch description.

Changes in version 2:
- completely redid the patch, fixing abuse of *unsigned long* for the CMT
  register values.

 drivers/clocksource/sh_cmt.c |   72 +++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

Index: tip/drivers/clocksource/sh_cmt.c
=================================--- tip.orig/drivers/clocksource/sh_cmt.c
+++ tip/drivers/clocksource/sh_cmt.c
@@ -78,18 +78,17 @@ struct sh_cmt_info {
 	unsigned int channels_mask;
 
 	unsigned long width; /* 16 or 32 bit version of hardware block */
-	unsigned long overflow_bit;
-	unsigned long clear_bits;
+	u32 overflow_bit;
+	u32 clear_bits;
 
 	/* callbacks for CMSTR and CMCSR access */
-	unsigned long (*read_control)(void __iomem *base, unsigned long offs);
+	u32 (*read_control)(void __iomem *base, unsigned long offs);
 	void (*write_control)(void __iomem *base, unsigned long offs,
-			      unsigned long value);
+			      u32 value);
 
 	/* callbacks for CMCNT and CMCOR access */
-	unsigned long (*read_count)(void __iomem *base, unsigned long offs);
-	void (*write_count)(void __iomem *base, unsigned long offs,
-			    unsigned long value);
+	u32 (*read_count)(void __iomem *base, unsigned long offs);
+	void (*write_count)(void __iomem *base, unsigned long offs, u32 value);
 };
 
 struct sh_cmt_channel {
@@ -103,9 +102,9 @@ struct sh_cmt_channel {
 
 	unsigned int timer_bit;
 	unsigned long flags;
-	unsigned long match_value;
-	unsigned long next_match_value;
-	unsigned long max_match_value;
+	u32 match_value;
+	u32 next_match_value;
+	u32 max_match_value;
 	raw_spinlock_t lock;
 	struct clock_event_device ced;
 	struct clocksource cs;
@@ -160,24 +159,22 @@ struct sh_cmt_device {
 #define SH_CMT32_CMCSR_CKS_RCLK1	(7 << 0)
 #define SH_CMT32_CMCSR_CKS_MASK		(7 << 0)
 
-static unsigned long sh_cmt_read16(void __iomem *base, unsigned long offs)
+static u32 sh_cmt_read16(void __iomem *base, unsigned long offs)
 {
 	return ioread16(base + (offs << 1));
 }
 
-static unsigned long sh_cmt_read32(void __iomem *base, unsigned long offs)
+static u32 sh_cmt_read32(void __iomem *base, unsigned long offs)
 {
 	return ioread32(base + (offs << 2));
 }
 
-static void sh_cmt_write16(void __iomem *base, unsigned long offs,
-			   unsigned long value)
+static void sh_cmt_write16(void __iomem *base, unsigned long offs, u32 value)
 {
 	iowrite16(value, base + (offs << 1));
 }
 
-static void sh_cmt_write32(void __iomem *base, unsigned long offs,
-			   unsigned long value)
+static void sh_cmt_write32(void __iomem *base, unsigned long offs, u32 value)
 {
 	iowrite32(value, base + (offs << 2));
 }
@@ -242,7 +239,7 @@ static const struct sh_cmt_info sh_cmt_i
 #define CMCNT 1 /* channel register */
 #define CMCOR 2 /* channel register */
 
-static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
+static inline u32 sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
 {
 	if (ch->iostart)
 		return ch->cmt->info->read_control(ch->iostart, 0);
@@ -250,8 +247,7 @@ static inline unsigned long sh_cmt_read_
 		return ch->cmt->info->read_control(ch->cmt->mapbase, 0);
 }
 
-static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch, u32 value)
 {
 	if (ch->iostart)
 		ch->cmt->info->write_control(ch->iostart, 0, value);
@@ -259,39 +255,35 @@ static inline void sh_cmt_write_cmstr(st
 		ch->cmt->info->write_control(ch->cmt->mapbase, 0, value);
 }
 
-static inline unsigned long sh_cmt_read_cmcsr(struct sh_cmt_channel *ch)
+static inline u32 sh_cmt_read_cmcsr(struct sh_cmt_channel *ch)
 {
 	return ch->cmt->info->read_control(ch->ioctrl, CMCSR);
 }
 
-static inline void sh_cmt_write_cmcsr(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmcsr(struct sh_cmt_channel *ch, u32 value)
 {
 	ch->cmt->info->write_control(ch->ioctrl, CMCSR, value);
 }
 
-static inline unsigned long sh_cmt_read_cmcnt(struct sh_cmt_channel *ch)
+static inline u32 sh_cmt_read_cmcnt(struct sh_cmt_channel *ch)
 {
 	return ch->cmt->info->read_count(ch->ioctrl, CMCNT);
 }
 
-static inline void sh_cmt_write_cmcnt(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmcnt(struct sh_cmt_channel *ch, u32 value)
 {
 	ch->cmt->info->write_count(ch->ioctrl, CMCNT, value);
 }
 
-static inline void sh_cmt_write_cmcor(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmcor(struct sh_cmt_channel *ch, u32 value)
 {
 	ch->cmt->info->write_count(ch->ioctrl, CMCOR, value);
 }
 
-static unsigned long sh_cmt_get_counter(struct sh_cmt_channel *ch,
-					int *has_wrapped)
+static u32 sh_cmt_get_counter(struct sh_cmt_channel *ch, u32 *has_wrapped)
 {
-	unsigned long v1, v2, v3;
-	int o1, o2;
+	u32 v1, v2, v3;
+	u32 o1, o2;
 
 	o1 = sh_cmt_read_cmcsr(ch) & ch->cmt->info->overflow_bit;
 
@@ -311,7 +303,8 @@ static unsigned long sh_cmt_get_counter(
 
 static void sh_cmt_start_stop_ch(struct sh_cmt_channel *ch, int start)
 {
-	unsigned long flags, value;
+	unsigned long flags;
+	u32 value;
 
 	/* start stop register shared by multiple timer channels */
 	raw_spin_lock_irqsave(&ch->cmt->lock, flags);
@@ -418,11 +411,11 @@ static void sh_cmt_disable(struct sh_cmt
 static void sh_cmt_clock_event_program_verify(struct sh_cmt_channel *ch,
 					      int absolute)
 {
-	unsigned long new_match;
-	unsigned long value = ch->next_match_value;
-	unsigned long delay = 0;
-	unsigned long now = 0;
-	int has_wrapped;
+	u32 value = ch->next_match_value;
+	u32 new_match;
+	u32 delay = 0;
+	u32 now = 0;
+	u32 has_wrapped;
 
 	now = sh_cmt_get_counter(ch, &has_wrapped);
 	ch->flags |= FLAG_REPROGRAM; /* force reprogram */
@@ -619,9 +612,10 @@ static struct sh_cmt_channel *cs_to_sh_c
 static u64 sh_cmt_clocksource_read(struct clocksource *cs)
 {
 	struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
-	unsigned long flags, raw;
+	unsigned long flags;
 	unsigned long value;
-	int has_wrapped;
+	u32 has_wrapped;
+	u32 raw;
 
 	raw_spin_lock_irqsave(&ch->lock, flags);
 	value = ch->total_cycles;
