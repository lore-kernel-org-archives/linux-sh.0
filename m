From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 09 Jul 2014 11:30:13 +0000
Subject: [PATCH 2/2] usb: renesas_usbhs: gadget: fix re-enabling pipe without re-connecting
Message-Id: <53BD27C5.80006@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes an issue that the renesas_usbhs driver in gadget mode
cannot work correctly even if I disabled DMAC of the driver when I used
the g_zero driver and the testusb tool.

When a usb cable is re-connected, the renesas_usbhs driver calls the
usbhsp_flags_init() (via usbhs_hotplug() --> usbhs_mod_call(start) -->
usbhsg_try_start() --> usbhs_pipe_init()). However, the driver doesn't
call the usbhsp_flags_init() when usbhsg_ep_disable() is called.
So, if a gadget driver calls usb_ep_enable() and usb_ep_disable() again
and again, the renesas_usbhs driver will output the following log:

  renesas_usbhs renesas_usbhs: can't get pipe (BULK)
  renesas_usbhs renesas_usbhs: wrong recip request

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/mod_gadget.c |    2 ++
 drivers/usb/renesas_usbhs/pipe.c       |   10 ++++++++++
 drivers/usb/renesas_usbhs/pipe.h       |    1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 458f376..04e6505 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -600,8 +600,10 @@ static int usbhsg_ep_enable(struct usb_ep *ep,
 static int usbhsg_ep_disable(struct usb_ep *ep)
 {
 	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
+	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);

 	usbhsg_pipe_disable(uep);
+	usbhs_pipe_free(pipe);

 	uep->pipe->mod_private	= NULL;
 	uep->pipe		= NULL;
diff --git a/drivers/usb/renesas_usbhs/pipe.c b/drivers/usb/renesas_usbhs/pipe.c
index 239b889..75fbcf6 100644
--- a/drivers/usb/renesas_usbhs/pipe.c
+++ b/drivers/usb/renesas_usbhs/pipe.c
@@ -640,6 +640,11 @@ static struct usbhs_pipe *usbhsp_get_pipe(struct usbhs_priv *priv, u32 type)
 	return pipe;
 }

+static void usbhsp_put_pipe(struct usbhs_pipe *pipe)
+{
+	usbhsp_flags_init(pipe);
+}
+
 void usbhs_pipe_init(struct usbhs_priv *priv,
 		     int (*dma_map_ctrl)(struct usbhs_pkt *pkt, int map))
 {
@@ -727,6 +732,11 @@ struct usbhs_pipe *usbhs_pipe_malloc(struct usbhs_priv *priv,
 	return pipe;
 }

+void usbhs_pipe_free(struct usbhs_pipe *pipe)
+{
+	usbhsp_put_pipe(pipe);
+}
+
 void usbhs_pipe_select_fifo(struct usbhs_pipe *pipe, struct usbhs_fifo *fifo)
 {
 	if (pipe->fifo)
diff --git a/drivers/usb/renesas_usbhs/pipe.h b/drivers/usb/renesas_usbhs/pipe.h
index 3e53498..406f36d 100644
--- a/drivers/usb/renesas_usbhs/pipe.h
+++ b/drivers/usb/renesas_usbhs/pipe.h
@@ -75,6 +75,7 @@ struct usbhs_pipe_info {
 char *usbhs_pipe_name(struct usbhs_pipe *pipe);
 struct usbhs_pipe
 *usbhs_pipe_malloc(struct usbhs_priv *priv, int endpoint_type, int dir_in);
+void usbhs_pipe_free(struct usbhs_pipe *pipe);
 int usbhs_pipe_probe(struct usbhs_priv *priv);
 void usbhs_pipe_remove(struct usbhs_priv *priv);
 int usbhs_pipe_is_dir_in(struct usbhs_pipe *pipe);
-- 
1.7.9.5

