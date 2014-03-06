From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 06 Mar 2014 18:01:20 +0000
Subject: [PATCH 2/9] phy-rcar-gen2-usb: always use 'dev' variable in probe() method
Message-Id: <1394128887-4197-3-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The probe() method has the 'dev' local variable declared and used but strangely
not in all cases where it should be...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
---
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/phy/phy-rcar-gen2-usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
index 551e0a6..388d89f 100644
--- a/drivers/usb/phy/phy-rcar-gen2-usb.c
+++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
@@ -177,15 +177,15 @@ static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int retval;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	pdata = dev_get_platdata(dev);
 	if (!pdata) {
 		dev_err(dev, "No platform data\n");
 		return -EINVAL;
 	}
 
-	clk = devm_clk_get(&pdev->dev, "usbhs");
+	clk = devm_clk_get(dev, "usbhs");
 	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "Can't get the clock\n");
+		dev_err(dev, "Can't get the clock\n");
 		return PTR_ERR(clk);
 	}
 
-- 
1.9.0

