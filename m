From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Nov 2009 08:12:55 +0000
Subject: [PATCH 02/02] clocksource: Start CMT at clocksource resume
Message-Id: <20091125081255.25416.85126.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20091125081235.25416.32481.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091125081235.25416.32481.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-sh@vger.kernel.org, johnstul@us.ibm.com, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm@opensource.se>

Add code to start the CMT timer on clocksource resume.

This makes sure the timer is started during sysdev_resume().
Without this patch the clocksource may be read as suspended,
this after sysdev resume but before platform device resume.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/sh_cmt.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- 0001/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2009-11-25 16:02:52.000000000 +0900
@@ -432,6 +432,13 @@ static void sh_cmt_clocksource_disable(s
 	sh_cmt_stop(cs_to_sh_cmt(cs), FLAG_CLOCKSOURCE);
 }
 
+static void sh_cmt_clocksource_resume(struct clocksource *cs)
+{
+	struct sh_cmt_priv *p = cs_to_sh_cmt(cs);
+
+	sh_cmt_start(p, FLAG_CLOCKSOURCE);
+}
+
 static int sh_cmt_register_clocksource(struct sh_cmt_priv *p,
 				       char *name, unsigned long rating)
 {
@@ -442,6 +449,7 @@ static int sh_cmt_register_clocksource(s
 	cs->read = sh_cmt_clocksource_read;
 	cs->enable = sh_cmt_clocksource_enable;
 	cs->disable = sh_cmt_clocksource_disable;
+	cs->resume = sh_cmt_clocksource_resume;
 	cs->mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
 	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
 	pr_info("sh_cmt: %s used as clock source\n", cs->name);
