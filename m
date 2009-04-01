From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 01 Apr 2009 14:11:07 +0000
Subject: [PATCH] sh_cmt: use remove_irq() and remove clockevent workaround
Message-Id: <20090401141107.32445.63752.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Update the sh_cmt driver to make use of recent irq and clockevent changes:
 - use remove_irq() together with setup_irq()
 - remove mult workaround since WARN_ON() now has been moved

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/clocksource/sh_cmt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- 0001/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2009-04-01 23:01:39.000000000 +0900
@@ -465,7 +465,6 @@ static void sh_cmt_register_clockevent(s
 	ced->set_mode = sh_cmt_clock_event_mode;
 
 	pr_info("sh_cmt: %s used for clock events\n", ced->name);
-	ced->mult = 1; /* work around misplaced WARN_ON() in clockevents.c */
 	clockevents_register_device(ced);
 }
 
@@ -557,7 +556,7 @@ static int sh_cmt_setup(struct sh_cmt_pr
 			       cfg->clockevent_rating,
 			       cfg->clocksource_rating);
  err2:
-	free_irq(irq, p);
+	remove_irq(irq, &p->irqaction);
  err1:
 	iounmap(p->mapbase);
  err0:
