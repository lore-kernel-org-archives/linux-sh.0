From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Apr 2009 08:17:54 +0000
Subject: [PATCH] clocksource: improve sh_cmt clocksource overflow handling
Message-Id: <20090428081754.16592.85760.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch improves the sh_cmt clocksource handling.

Currently the counter value is ignored in the case of
overflow. With this patch the overflow flag is read
before and after reading the counter, removing any
counter value and overflow flag mismatch issues.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/clocksource/sh_cmt.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- 0001/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2009-04-28 16:03:20.000000000 +0900
@@ -111,16 +111,21 @@ static unsigned long sh_cmt_get_counter(
 					int *has_wrapped)
 {
 	unsigned long v1, v2, v3;
+	int o1, o2;
+
+	o1 = sh_cmt_read(p, CMCSR) & p->overflow_bit;
 
 	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
 	do {
+		o2 = o1;
 		v1 = sh_cmt_read(p, CMCNT);
 		v2 = sh_cmt_read(p, CMCNT);
 		v3 = sh_cmt_read(p, CMCNT);
-	} while (unlikely((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
-			  || (v3 > v1 && v3 < v2)));
+		o1 = sh_cmt_read(p, CMCSR) & p->overflow_bit;
+	} while (unlikely((o1 != o2) || (v1 > v2 && v1 < v3)
+			  || (v2 > v3 && v2 < v1) || (v3 > v1 && v3 < v2)));
 
-	*has_wrapped = sh_cmt_read(p, CMCSR) & p->overflow_bit;
+	*has_wrapped = o1;
 	return v2;
 }
 
@@ -394,7 +399,7 @@ static cycle_t sh_cmt_clocksource_read(s
 	raw = sh_cmt_get_counter(p, &has_wrapped);
 
 	if (unlikely(has_wrapped))
-		raw = p->match_value;
+		raw += p->match_value;
 	spin_unlock_irqrestore(&p->lock, flags);
 
 	return value + raw;
