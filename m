From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 29 Sep 2015 09:21:18 +0000
Subject: [PATCH v2 1/2] usb: renesas_usbhs: fix build warning if 64-bit architecture
Message-Id: <1443518479-2864-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443518479-2864-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1443518479-2864-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

This patch fixes the following warning if 64-bit architecture environment:

./drivers/usb/renesas_usbhs/common.c:496:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  dparam->type = of_id ? (u32)of_id->data : 0;

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 2 +-
 include/linux/usb/renesas_usbhs.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 7b98e1d..0ce398c 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -493,7 +493,7 @@ static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
 		return NULL;
 
 	dparam = &info->driver_param;
-	dparam->type = of_id ? (u32)of_id->data : 0;
+	dparam->type = of_id ? (uintptr_t)of_id->data : 0;
 	if (!of_property_read_u32(dev->of_node, "renesas,buswait", &tmp))
 		dparam->buswait_bwait = tmp;
 	gpio = of_get_named_gpio_flags(dev->of_node, "renesas,enable-gpio", 0,
diff --git a/include/linux/usb/renesas_usbhs.h b/include/linux/usb/renesas_usbhs.h
index 3dd5a78..bfb7472 100644
--- a/include/linux/usb/renesas_usbhs.h
+++ b/include/linux/usb/renesas_usbhs.h
@@ -157,7 +157,7 @@ struct renesas_usbhs_driver_param {
 	 */
 	int pio_dma_border; /* default is 64byte */
 
-	u32 type;
+	uintptr_t type;
 	u32 enable_gpio;
 
 	/*
-- 
1.9.1

