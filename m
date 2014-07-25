From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 25 Jul 2014 17:46:57 +0000
Subject: [RFC PATCH 2/3] PM / clock_ops: allow to specify custom pm_clk_notifier callback
Message-Id: <1406313096-29761-3-git-send-email-grygorii.strashko@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1406313096-29761-1-git-send-email-grygorii.strashko@ti.com>
In-Reply-To: <1406313096-29761-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The CLK PM domain assumes that platform code should always provide
list of Connection IDs of the clock (con_id) in
pm_clk_notifier_block structure. Then CLK PM domain uses these con_ids
to setup list of clocks per device.

Such approach is inconvenient when devices can have different number
of clocks. For example, if maximum number of clocks used by
device is 4 the pm_clk_notifier_block structure will look like:

static struct pm_clk_notifier_block platform_domain_notifier = {
	.pm_domain = &keystone_pm_domain,
	.con_ids = { "fck", "opt1", "opt2", "opt3", NULL },
};

More over, clocks in DT have to be named using only con_ids:
	clocks = <&paclk13>, <&clkcpgmac>, <&chipclk12>;
	clock-names = "fck", "opt1", "opt2";

This patch allow to specify custom pm_clk_notifier callback from
platform code and in such way makes CLK PM domain initialization
more flexible. For example, Keystone 2 will provide custom callback
to fill list of clocks for Device with all clocks assigned to this
Device in DT.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/base/power/clock_ops.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 2d5c9c1..c103598 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -520,6 +520,7 @@ void pm_clk_add_notifier(struct bus_type *bus,
 	if (!bus || !clknb)
 		return;
 
-	clknb->nb.notifier_call = pm_clk_notify;
+	if (!clknb->nb.notifier_call)
+		clknb->nb.notifier_call = pm_clk_notify;
 	bus_register_notifier(bus, &clknb->nb);
 }
-- 
1.7.9.5

