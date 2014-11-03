From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 03 Nov 2014 15:34:52 +0000
Subject: [PATCH v4 5/9] ARM: shmobile: R-Mobile: Enable module clocks if !CONFIG_PM_RUNTIME
Message-Id: <1415028896-9005-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1415028896-9005-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415028896-9005-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

If CONFIG_PM_RUNTIME is not set, the clocks must be enabled before the
devices can be used.

Currently these clocks are enabled by the !CONFIG_PM_RUNTIME version of
pm_clk_notify, activated by the hack in drivers/sh/pm_runtime.c, but
this will go away soon (at least for DT).

On detach, disabling the clocks is already handled by pm_clk_destroy().
On system suspend/resume, disabling/enabling clocks is already handled
from the genpd->dev_ops.{start,stop}() callbacks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 arch/arm/mach-shmobile/pm-rmobile.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 068608d5f54a9a64..6fb86cdb9fa2b3a7 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -117,6 +117,14 @@ static int rmobile_pd_attach_dev(struct device *dev)
 		goto fail;
 	}
 
+	if (!IS_ENABLED(CONFIG_PM_RUNTIME)) {
+		error = pm_clk_resume(dev);
+		if (error) {
+			dev_err(dev, "pm_clk_resume failed %d\n", error);
+			goto fail;
+		}
+	}
+
 	return 0;
 
 fail:
-- 
1.9.1

