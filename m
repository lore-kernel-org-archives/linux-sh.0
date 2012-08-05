From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 05 Aug 2012 23:47:29 +0000
Subject: [PATCH 11/15] PM / Domains: Do not measure start time for "irq safe" devices
Message-Id: <201208060147.29559.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207291612.43138.rjw@sisk.pl> <201208060138.03950.rjw@sisk.pl>
In-Reply-To: <201208060138.03950.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>


The genpd_start_dev() routine used by pm_genpd_runtime_resume()
to put "irq safe" devices into the full power state measures the
time necessary to "start" the device and updates its PM QoS timing
data if necessary.  This may lead to a deadlock if the given device
is a clock source and genpd_start_dev() is invoked from within the
clock source's .enable() routine, which will happen if that routine
uses pm_runtime_get_sync(), for example, to ensure that the device
is operational.

For this reason, introduce a special routine analogous to
genpd_start_dev(), called genpd_start_dev_no_timing(), that doesn't
carry out the time measurement, and make pm_genpd_runtime_resume()
use it instead of genpd_start_dev() to power up "irq safe" devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux/drivers/base/power/domain.c
=================================--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -75,6 +75,12 @@ static int genpd_start_dev(struct generi
 					start_latency_ns, "start");
 }
 
+static int genpd_start_dev_no_timing(struct generic_pm_domain *genpd,
+				     struct device *dev)
+{
+	return GENPD_DEV_CALLBACK(genpd, int, start, dev);
+}
+
 static bool genpd_sd_counter_dec(struct generic_pm_domain *genpd)
 {
 	bool ret = false;
@@ -626,7 +632,7 @@ static int pm_genpd_runtime_resume(struc
 
 	/* If power.irq_safe, the PM domain is never powered off. */
 	if (dev->power.irq_safe)
-		return genpd_start_dev(genpd, dev);
+		return genpd_start_dev_no_timing(genpd, dev);
 
 	mutex_lock(&genpd->lock);
 	ret = __pm_genpd_poweron(genpd);

