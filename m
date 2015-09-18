From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 18 Sep 2015 11:08:27 +0000
Subject: [PATCH v4 04/10] serial: sh-sci: Stop calling sci_start_rx() from sci_request_dma()
Message-Id: <1442574513-20648-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Muhammad Hamza Farooq <mfarooq@visteon.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

There's no need to call sci_start_rx() from sci_request_dma() when DMA
setup fails, as sci_startup() will call sci_start_rx() anyway.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 drivers/tty/serial/sh-sci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 02aaf4d213d9c280..ac9ce8f1ff799a48 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1386,7 +1386,6 @@ static void sci_request_dma(struct uart_port *port)
 				 "Failed to allocate Rx dma buffer, using PIO\n");
 			dma_release_channel(chan);
 			s->chan_rx = NULL;
-			sci_start_rx(port);
 			return;
 		}
 
-- 
1.9.1

