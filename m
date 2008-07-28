From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jul 2008 12:32:29 +0000
Subject: [PATCH] USB: m66592-udc: Fix up dev_set_name() badness.
Message-Id: <20080728123229.GA15202@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Commit 0031a06e2f07ab0d1bc98c31dbb6801f95f4bf01 converted all of the USB
drivers to use dev_set_name(), though there was a typo on the m66592-udc
conversion that handed off the wrong pointer (we want the struct device
here obviously, not the struct usb_gadget).

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/usb/gadget/m66592-udc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/m66592-udc.c b/drivers/usb/gadget/m66592-udc.c
index 8da7535..77b44fb 100644
--- a/drivers/usb/gadget/m66592-udc.c
+++ b/drivers/usb/gadget/m66592-udc.c
@@ -1593,7 +1593,7 @@ static int __init m66592_probe(struct platform_device *pdev)
 
 	m66592->gadget.ops = &m66592_gadget_ops;
 	device_initialize(&m66592->gadget.dev);
-	dev_set_name(&m66592->gadget, "gadget");
+	dev_set_name(&m66592->gadget.dev, "gadget");
 	m66592->gadget.is_dualspeed = 1;
 	m66592->gadget.dev.parent = &pdev->dev;
 	m66592->gadget.dev.dma_mask = pdev->dev.dma_mask;
