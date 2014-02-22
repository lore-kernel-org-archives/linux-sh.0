From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 22 Feb 2014 00:29:13 +0000
Subject: [PATCH] phy-rcar-gen2-usb: always use 'dev' variable in probe() method
Message-Id: <201402220429.15888.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The probe() method has the 'dev' local variable declared and used but strangely
not in all cases where it should be...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'next' branch of Felipe Balbi's 'usb.git' repo.

 drivers/usb/phy/phy-rcar-gen2-usb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: usb/drivers/usb/phy/phy-rcar-gen2-usb.c
=================================--- usb.orig/drivers/usb/phy/phy-rcar-gen2-usb.c
+++ usb/drivers/usb/phy/phy-rcar-gen2-usb.c
@@ -177,15 +177,15 @@ static int rcar_gen2_usb_phy_probe(struc
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
 
