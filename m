From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 31 Oct 2014 04:20:08 +0000
Subject: [PATCH v5 1/4] usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()
Message-Id: <1414729211-3276-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

This patch fixes an issue that the NULL pointer dereference happens
when we uses g_audio driver. Since the g_audio driver will call
usb_ep_disable() in afunc_set_alt() before it calls usb_ep_enable(),
the uep->pipe of renesas usbhs driver will be NULL. So, this patch
adds a condition to avoid the oops.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Fixes: 132fcb4608 (usb: gadget: Add Audio Class 2.0 Driver)
Cc: <stable@vger.kernel.org> # v3.3+
---
 drivers/usb/renesas_usbhs/mod_gadget.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 2d17c10..294d43c 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -602,6 +602,9 @@ static int usbhsg_ep_disable(struct usb_ep *ep)
 	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
 	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
 
+	if (!pipe)
+		return -EINVAL;
+
 	usbhsg_pipe_disable(uep);
 	usbhs_pipe_free(pipe);
 
-- 
1.7.9.5

