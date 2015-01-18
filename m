From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 18 Jan 2015 22:59:09 +0000
Subject: [PATCH 21/23] renesas_usbhs: mod_host: use HUB_CHAR_*
Message-Id: <6740241.zUR9nh3WrW@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix  using the  bare number  to set the 'wHubCharacteristics' field of the Hub
Descriptor while the values are #define'd in <linux/usb/ch11.h>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/usb/renesas_usbhs/mod_host.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: usb/drivers/usb/renesas_usbhs/mod_host.c
=================================--- usb.orig/drivers/usb/renesas_usbhs/mod_host.c
+++ usb/drivers/usb/renesas_usbhs/mod_host.c
@@ -1234,7 +1234,8 @@ static int __usbhsh_hub_get_status(struc
 		desc->bNbrPorts			= roothub_id;
 		desc->bDescLength		= 9;
 		desc->bPwrOn2PwrGood		= 0;
-		desc->wHubCharacteristics	= cpu_to_le16(0x0011);
+		desc->wHubCharacteristics	+			cpu_to_le16(HUB_CHAR_INDV_PORT_LPSM | HUB_CHAR_NO_OCPM);
 		desc->u.hs.DeviceRemovable[0]	= (roothub_id << 1);
 		desc->u.hs.DeviceRemovable[1]	= ~0;
 		dev_dbg(dev, "%s :: GetHubDescriptor\n", __func__);

