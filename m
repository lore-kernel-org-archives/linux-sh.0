From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 31 Jul 2011 17:47:00 +0000
Subject: [PATCH 1/9] PM / Domains: Fix pm_genpd_poweron()
Message-Id: <201107311947.00477.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201107311946.06654.rjw@sisk.pl>
In-Reply-To: <201107311946.06654.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The local variable ret is defined twice in pm_genpd_poweron(), which
causes this function to always return 0, even if the PM domain's
.power_on() callback fails, in which case an error code should be
returned.

Remove the wrong second definition of ret and additionally remove an
unnecessary definition of wait from pm_genpd_poweron().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/drivers/base/power/domain.c
=================================--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -80,7 +80,6 @@ static void genpd_set_active(struct gene
 int pm_genpd_poweron(struct generic_pm_domain *genpd)
 {
 	struct generic_pm_domain *parent = genpd->parent;
-	DEFINE_WAIT(wait);
 	int ret = 0;
 
  start:
@@ -112,7 +111,7 @@ int pm_genpd_poweron(struct generic_pm_d
 	}
 
 	if (genpd->power_on) {
-		int ret = genpd->power_on(genpd);
+		ret = genpd->power_on(genpd);
 		if (ret)
 			goto out;
 	}

