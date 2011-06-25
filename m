From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 25 Jun 2011 21:29:24 +0000
Subject: [PATCH 7/10 v6] PM / Domains: Don't stop wakeup devices during system sleep transitions
Message-Id: <201106252329.24342.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201106112223.04972.rjw@sisk.pl> <201106252324.13454.rjw@sisk.pl>
In-Reply-To: <201106252324.13454.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Devices that are set up to wake up the system from sleep states
should not be stopped and power should not be removed from them
when the system goes into a sleep state.  Make the generic PM domain
code respect that limitation.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6/drivers/base/power/domain.c
=================================--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -445,6 +445,9 @@ static int pm_genpd_suspend_noirq(struct
 	if (ret)
 		return ret;
 
+	if (device_may_wakeup(dev))
+		return 0;
+
 	if (genpd->stop_device)
 		genpd->stop_device(dev);
 
@@ -665,6 +668,9 @@ static int pm_genpd_dev_poweroff_noirq(s
 	if (ret)
 		return ret;
 
+	if (device_may_wakeup(dev))
+		return 0;
+
 	if (genpd->stop_device)
 		genpd->stop_device(dev);
 

