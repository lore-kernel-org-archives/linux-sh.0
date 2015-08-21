From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 21 Aug 2015 18:02:56 +0000
Subject: [PATCH v3 32/33] serial: sh-sci: Don't kick tx in sci_er_interrupt() when using DMA
Message-Id: <1440180177-6924-33-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

If CONFIG_SERIAL_SH_SCI_DMA is enabled, the driver doesn't enable TIE
on SCIF or HSCIF. However, this driver may call sci_tx_interrupt()
in sci_er_interrupt(). After that, the driver cannot care of the
interrupt, and then "irq 109: nobody cared" happens on r8a7791/koelsch
board. This patch fixes the issue.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[geert] Keep kicking tx when using PIO
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Assimilated into my series.
---
 drivers/tty/serial/sh-sci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 82456fb09138dc2a..ffcbf6eaf5f98723 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1011,7 +1011,8 @@ static irqreturn_t sci_er_interrupt(int irq, void *ptr)
 	sci_clear_SCxSR(port, SCxSR_ERROR_CLEAR(port));
 
 	/* Kick the transmission */
-	sci_tx_interrupt(irq, ptr);
+	if (!s->chan_tx)
+		sci_tx_interrupt(irq, ptr);
 
 	return IRQ_HANDLED;
 }
-- 
1.9.1

