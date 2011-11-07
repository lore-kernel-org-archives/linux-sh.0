From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 07 Nov 2011 00:10:38 +0000
Subject: [PATCH 7/7] PM / Domains: Automatically update overoptimistic latency information
Message-Id: <201111070110.38976.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201111070101.33960.rjw@sisk.pl>
In-Reply-To: <201111070101.33960.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

From: Rafael J. Wysocki <rjw@sisk.pl>

Measure the time of execution of the .start(), .save_state()
and .restore_state() PM domain device callbacks and if the result
is greater than the corresponding latency value stored in the
device's struct generic_pm_domain_data object, replace the inaccurate
value with the measured time.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

Index: linux/drivers/base/power/domain.c
=================================--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -32,6 +32,17 @@
 	__ret;							\
 })
 
+#define GENPD_DEV_TIMED_CALLBACK(genpd, type, callback, dev, latency)	\
+({									\
+	ktime_t __start = ktime_get();					\
+	type __retval = GENPD_DEV_CALLBACK(genpd, type, callback, dev);	\
+	s64 __elapsed = ktime_to_ns(ktime_sub(ktime_get(), __start));	\
+	struct generic_pm_domain_data *__gpd_data = dev_gpd_data(dev);	\
+	if (__elapsed > __gpd_data->td.latency)				\
+		__gpd_data->td.latency = __elapsed;			\
+	__retval;							\
+})
+
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
@@ -53,17 +64,20 @@ static int genpd_stop_dev(struct generic
 
 static int genpd_start_dev(struct generic_pm_domain *genpd, struct device *dev)
 {
-	return GENPD_DEV_CALLBACK(genpd, int, start, dev);
+	return GENPD_DEV_TIMED_CALLBACK(genpd, int, start, dev,
+					start_latency_ns);
 }
 
 static int genpd_save_dev(struct generic_pm_domain *genpd, struct device *dev)
 {
-	return GENPD_DEV_CALLBACK(genpd, int, save_state, dev);
+	return GENPD_DEV_TIMED_CALLBACK(genpd, int, save_state, dev,
+					save_state_latency_ns);
 }
 
 static int genpd_restore_dev(struct generic_pm_domain *genpd, struct device *dev)
 {
-	return GENPD_DEV_CALLBACK(genpd, int, restore_state, dev);
+	return GENPD_DEV_TIMED_CALLBACK(genpd, int, restore_state, dev,
+					restore_state_latency_ns);
 }
 
 static bool genpd_sd_counter_dec(struct generic_pm_domain *genpd)

