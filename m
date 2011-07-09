From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 09 Jul 2011 14:15:38 +0000
Subject: Re: [Update][PATCH 6/10] PM / Domains: System-wide transitions support for generic domains (v5)
Message-Id: <201107091615.38915.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.44L0.1107081033000.2208-100000@iolanthe.rowland.org> <201107082006.49660.rjw@sisk.pl> <201107082124.24921.rjw@sisk.pl>
In-Reply-To: <201107082124.24921.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kevin Hilman <khilman@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

On Friday, July 08, 2011, Rafael J. Wysocki wrote:
...
> 
> Well, in fact, since we already have .active_wakeup(), what about the
> following patch (on top of https://lkml.org/lkml/2011/7/8/223):

Well, it is wrong, because we've been discussing devices that are _not_
enabled to wake up the system.

> ---
>  drivers/base/power/domain.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> Index: linux-2.6/drivers/base/power/domain.c
> =================================> --- linux-2.6.orig/drivers/base/power/domain.c
> +++ linux-2.6/drivers/base/power/domain.c
> @@ -519,6 +519,10 @@ static int pm_genpd_prepare(struct devic
>  		return -EBUSY;
>  	}
>  
> +	if (device_may_wakeup(dev)

So, this should have been !device_may_wakeup(dev), _but_ ...

> +	    && !(genpd->active_wakeup && genpd->active_wakeup(dev)))
> +		pm_runtime_resume(dev);
> +
>  	genpd_acquire_lock(genpd);
>  
>  	if (genpd->prepared_count++ = 0)

There's one more case to consider, namely devices that are runtime
suspended, set up to wake up the system from sleep states (ie. device_may_wakeup(dev)
returns "true") and such that genpd->active_wakeup(dev) returns "true" for them,
because they need to be resumed at this point too (arguably, it makes a little
sense to runtime suspend such devices, but that's possible in principle).

So, IMO, the patch should look like this:

---
 drivers/base/power/domain.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Index: linux-2.6/drivers/base/power/domain.c
=================================--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -486,6 +486,22 @@ static void pm_genpd_sync_poweroff(struc
 }
 
 /**
+ * resume_needed - Check whether to resume a device before system suspend.
+ * @dev: Device to handle.
+ * @genpd: PM domain the device belongs to.
+ */
+static bool resume_needed(struct device *dev, struct generic_pm_domain *genpd)
+{
+	bool active_wakeup;
+
+	if (!device_can_wakeup(dev))
+		return false;
+
+	active_wakeup = genpd->active_wakeup && genpd->active_wakeup(dev);
+	return device_may_wakeup(dev) ? active_wakeup : !active_wakeup;
+}
+
+/**
  * pm_genpd_prepare - Start power transition of a device in a PM domain.
  * @dev: Device to start the transition of.
  *
@@ -519,6 +535,9 @@ static int pm_genpd_prepare(struct devic
 		return -EBUSY;
 	}
 
+	if (resume_needed(dev, genpd))
+		pm_runtime_resume(dev);
+
 	genpd_acquire_lock(genpd);
 
 	if (genpd->prepared_count++ = 0)
