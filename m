From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Jun 2014 00:40:35 +0000
Subject: [PATCH 01/05] serial: sh-sci: Allow AUXDATA DMAC parameters
Message-Id: <20140625004035.18295.42356.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Allow passing platform data also in the case of DT. With
this in place it is possible to use AUXDATA together with
platform data to specify DMA channel configuration.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/tty/serial/sh-sci.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- 0001/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2014-06-25 08:11:20.000000000 +0900
@@ -2470,9 +2470,13 @@ sci_parse_dt(struct platform_device *pde
 
 	info = match->data;
 
-	p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port), GFP_KERNEL);
+	if (pdev->dev.platform_data)
+		p = pdev->dev.platform_data;
+	else
+		p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port),
+				 GFP_KERNEL);
 	if (!p) {
-		dev_err(&pdev->dev, "failed to allocate DT config data\n");
+		dev_err(&pdev->dev, "failed to get DT config data\n");
 		return NULL;
 	}
 
