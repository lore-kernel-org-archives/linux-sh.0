From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 30 Oct 2014 04:02:47 +0000
Subject: [PATCH v2 4/4] usb: renesas_usbhs: fix usbhs_pipe_clear() for DCP PIPE
Message-Id: <1414641767-5780-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since the DCPCTR doesn't have the ACLRM bit, the usbus_pipe_clear()
should not call the usbhsp_pipectrl_set() with ACLRM.
So, this patch fixes this issue to add the usbhs_fifo_clear_dcp()
in fifo.c because the controller needs the CFIFO to clear the
the DCP PIPE.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c       |   18 ++++++++++++++++++
 drivers/usb/renesas_usbhs/fifo.h       |    1 +
 drivers/usb/renesas_usbhs/mod_gadget.c |    2 +-
 drivers/usb/renesas_usbhs/mod_host.c   |    2 +-
 drivers/usb/renesas_usbhs/pipe.c       |    8 ++++++--
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 0e07925..9b48384 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -1160,6 +1160,24 @@ static void usbhsf_dma_complete(void *arg)
 			usbhs_pipe_number(pipe), ret);
 }
 
+void usbhs_fifo_clear_dcp(struct usbhs_pipe *pipe)
+{
+	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
+	struct usbhs_fifo *fifo = usbhsf_get_cfifo(priv); /* CFIFO */
+
+	/* clear DCP FIFO of transmission */
+	if (usbhsf_fifo_select(pipe, fifo, 1) < 0)
+		return;
+	usbhsf_fifo_clear(pipe, fifo);
+	usbhsf_fifo_unselect(pipe, fifo);
+
+	/* clear DCP FIFO of reception */
+	if (usbhsf_fifo_select(pipe, fifo, 0) < 0)
+		return;
+	usbhsf_fifo_clear(pipe, fifo);
+	usbhsf_fifo_unselect(pipe, fifo);
+}
+
 /*
  *		fifo init
  */
diff --git a/drivers/usb/renesas_usbhs/fifo.h b/drivers/usb/renesas_usbhs/fifo.h
index a168a17..79ad5f9 100644
--- a/drivers/usb/renesas_usbhs/fifo.h
+++ b/drivers/usb/renesas_usbhs/fifo.h
@@ -74,6 +74,7 @@ int usbhs_fifo_probe(struct usbhs_priv *priv);
 void usbhs_fifo_remove(struct usbhs_priv *priv);
 void usbhs_fifo_init(struct usbhs_priv *priv);
 void usbhs_fifo_quit(struct usbhs_priv *priv);
+void usbhs_fifo_clear_dcp(struct usbhs_pipe *pipe);
 
 /*
  * packet info
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index f7adb3e..4d6c18a 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -782,9 +782,9 @@ static int usbhsg_try_start(struct usbhs_priv *priv, u32 status)
 	/*
 	 * pipe initialize and enable DCP
 	 */
+	usbhs_fifo_init(priv);
 	usbhs_pipe_init(priv,
 			usbhsg_dma_map_ctrl);
-	usbhs_fifo_init(priv);
 
 	/* dcp init instead of usbhsg_ep_enable() */
 	dcp->pipe		= usbhs_dcp_malloc(priv);
diff --git a/drivers/usb/renesas_usbhs/mod_host.c b/drivers/usb/renesas_usbhs/mod_host.c
index 10e1ded..f0d3231 100644
--- a/drivers/usb/renesas_usbhs/mod_host.c
+++ b/drivers/usb/renesas_usbhs/mod_host.c
@@ -1474,9 +1474,9 @@ static int usbhsh_start(struct usbhs_priv *priv)
 	/*
 	 * pipe initialize and enable DCP
 	 */
+	usbhs_fifo_init(priv);
 	usbhs_pipe_init(priv,
 			usbhsh_dma_map_ctrl);
-	usbhs_fifo_init(priv);
 	usbhsh_pipe_init_for_host(priv);
 
 	/*
diff --git a/drivers/usb/renesas_usbhs/pipe.c b/drivers/usb/renesas_usbhs/pipe.c
index 040bcef..007f45a 100644
--- a/drivers/usb/renesas_usbhs/pipe.c
+++ b/drivers/usb/renesas_usbhs/pipe.c
@@ -618,8 +618,12 @@ void usbhs_pipe_data_sequence(struct usbhs_pipe *pipe, int sequence)
 
 void usbhs_pipe_clear(struct usbhs_pipe *pipe)
 {
-	usbhsp_pipectrl_set(pipe, ACLRM, ACLRM);
-	usbhsp_pipectrl_set(pipe, ACLRM, 0);
+	if (usbhs_pipe_is_dcp(pipe)) {
+		usbhs_fifo_clear_dcp(pipe);
+	} else {
+		usbhsp_pipectrl_set(pipe, ACLRM, ACLRM);
+		usbhsp_pipectrl_set(pipe, ACLRM, 0);
+	}
 }
 
 static struct usbhs_pipe *usbhsp_get_pipe(struct usbhs_priv *priv, u32 type)
-- 
1.7.9.5

