From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Dec 2012 05:54:28 +0000
Subject: [PATCH 07/08] clocksource: sh_cmt: Add control register callbacks
Message-Id: <20121214055428.10081.36410.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20121214055323.10081.12056.sendpatchset@w520>
In-Reply-To: <20121214055323.10081.12056.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, johnstul@us.ibm.com, horms@verge.net.au, shinya.kuribayashi.px@renesas.com, tglx@linutronix.de, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

This patch adds control register callbacks for the CMT
driver. At this point only 16-bit access is supported
but in the future this will be updated to allow 32-bit
access as well.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/sh_cmt.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- 0004/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2012-12-14 11:28:57.000000000 +0900
@@ -55,6 +55,11 @@ struct sh_cmt_priv {
 	unsigned long total_cycles;
 	bool cs_enabled;
 
+	/* callbacks for CMSTR and CMCSR access */
+	unsigned long (*read_control)(void __iomem *base, unsigned long offs);
+	void (*write_control)(void __iomem *base, unsigned long offs,
+			      unsigned long value);
+
 	/* callbacks for CMCNT and CMCOR access */
 	unsigned long (*read_count)(void __iomem *base, unsigned long offs);
 	void (*write_count)(void __iomem *base, unsigned long offs,
@@ -94,12 +99,12 @@ static inline unsigned long sh_cmt_read_
 {
 	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
 
-	return sh_cmt_read16(p->mapbase - cfg->channel_offset, 0);
+	return p->read_control(p->mapbase - cfg->channel_offset, 0);
 }
 
 static inline unsigned long sh_cmt_read_cmcsr(struct sh_cmt_priv *p)
 {
-	return sh_cmt_read16(p->mapbase, CMCSR);
+	return p->read_control(p->mapbase, CMCSR);
 }
 
 static inline unsigned long sh_cmt_read_cmcnt(struct sh_cmt_priv *p)
@@ -112,13 +117,13 @@ static inline void sh_cmt_write_cmstr(st
 {
 	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
 
-	sh_cmt_write16(p->mapbase - cfg->channel_offset, 0, value);
+	p->write_control(p->mapbase - cfg->channel_offset, 0, value);
 }
 
 static inline void sh_cmt_write_cmcsr(struct sh_cmt_priv *p,
 				      unsigned long value)
 {
-	sh_cmt_write16(p->mapbase, CMCSR, value);
+	p->write_control(p->mapbase, CMCSR, value);
 }
 
 static inline void sh_cmt_write_cmcnt(struct sh_cmt_priv *p,
@@ -714,6 +719,9 @@ static int sh_cmt_setup(struct sh_cmt_pr
 		goto err1;
 	}
 
+	p->read_control = sh_cmt_read16;
+	p->write_control = sh_cmt_write16;
+
 	if (resource_size(res) = 6) {
 		p->width = 16;
 		p->read_count = sh_cmt_read16;
