From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 10 Nov 2011 12:05:56 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 A4R suspend/resume order fix
Message-Id: <201111101305.56887.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20110927085408.27727.59395.sendpatchset@w520>
In-Reply-To: <20110927085408.27727.59395.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, November 09, 2011, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the sh7372 A4R code to make sure the suspend
> callback gets to be called before the resume callback.
> 
> Without this fix the A4R resume callback is called before
> suspend. The resume callback restores the INTCS hardware
> registers with incorrect data which results in interrupts
> being masked when they shouldn't be. The user will notice
> this issue as IIC0 timing out during boot.
> 
> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Well, I'd prefer to do something like the patch below instead.

Please let me know what you think.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / shmobile: Avoid restoring the INTCS state during initialization

The SH7372 PM domain initialization routine calls pd_power_up()
that executes the domain's .resume() callback, if present, and for
the A4R domain this callback attepmts to restore the INTCS state from
uninitialized data.  To avoid that, introduce __pd_power_up() that
will only execute the domain's .resume() callback if its second
argument is 'true' and make the SH7372 PM domain initialization
use it with 'false' as its second argument.  Redefine pd_power_up()
as a wrapper around __pd_power_up().

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/pm-sh7372.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux/arch/arm/mach-shmobile/pm-sh7372.c
@@ -107,9 +107,8 @@ static int pd_power_down(struct generic_
 	return 0;
 }
 
-static int pd_power_up(struct generic_pm_domain *genpd)
+static int __pd_power_up(struct sh7372_pm_domain *sh7372_pd, bool do_resume)
 {
-	struct sh7372_pm_domain *sh7372_pd = to_sh7372_pd(genpd);
 	unsigned int mask = 1 << sh7372_pd->bit_shift;
 	unsigned int retry_count;
 	int ret = 0;
@@ -138,12 +137,17 @@ static int pd_power_up(struct generic_pm
 			 mask, __raw_readl(PSTR));
 
  out:
-	if (ret = 0 && sh7372_pd->resume)
+	if (ret = 0 && sh7372_pd->resume && do_resume)
 		sh7372_pd->resume();
 
 	return ret;
 }
 
+static int pd_power_up(struct generic_pm_domain *genpd)
+{
+	 return __pd_power_up(to_sh7372_pd(genpd), true);
+}
+
 static void sh7372_a4r_suspend(void)
 {
 	sh7372_intcs_suspend();
@@ -209,7 +213,7 @@ void sh7372_init_pm_domain(struct sh7372
 	genpd->dev_irq_safe = true;
 	genpd->power_off = pd_power_down;
 	genpd->power_on = pd_power_up;
-	genpd->power_on(&sh7372_pd->genpd);
+	__pd_power_up(sh7372_pd, false);
 }
 
 void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
