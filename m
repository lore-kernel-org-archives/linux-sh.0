From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 07 Jan 2015 01:13:10 +0000
Subject: [PATCH v2 1/2] thermal: rcar: fix ENR register value
Message-Id: <1420593191-3736-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420593191-3736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1420593191-3736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On R-Mobile APE6, since it has 3 thermal zones, ENR register
has enable bits in bit 19-16, bit 11-8 and bit 3-0.

However, on R-Car gen2, since it has 1 thermal zone, ENR register has
enable bits in bit 3-0. (In other words, the write value should always
be 0 for bit 31-4 of ENR register.)

So, this patch fixes the ENR register value using I/O resource sets.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/thermal/rcar_thermal.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8803e69..2f3b4ff 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -372,6 +372,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	int i;
 	int ret = -ENODEV;
 	int idle = IDLE_INTERVAL;
+	u32 enr_bits = 0;
 
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
 	if (!common)
@@ -408,9 +409,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		if (IS_ERR(common->base))
 			return PTR_ERR(common->base);
 
-		/* enable temperature comparation */
-		rcar_thermal_common_write(common, ENR, 0x00030303);
-
 		idle = 0; /* polling delay is not needed */
 	}
 
@@ -452,8 +450,15 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			rcar_thermal_irq_enable(priv);
 
 		list_move_tail(&priv->list, &common->head);
+
+		/* update ENR bits */
+		enr_bits |= 3 << (i * 8);
 	}
 
+	/* enable temperature comparation */
+	if (irq)
+		rcar_thermal_common_write(common, ENR, enr_bits);
+
 	platform_set_drvdata(pdev, common);
 
 	dev_info(dev, "%d sensor probed\n", i);
-- 
1.7.9.5

