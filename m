From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 14 Dec 2015 18:57:14 +0000
Subject: [PATCH v3 05/27] serial: sh-sci: Drop useless check for zero sampling_rate
Message-Id: <1450119456-964-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

sci_port.sampling_rate is always non-zero, except for HSCIF, which uses
sci_baud_calc_hscif() instead of sci_scbrr_calc().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Reviewed-by, Acked-by,
---
 drivers/tty/serial/sh-sci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index cc6fa55231ba3536..dfee7a2f51f147d1 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1863,13 +1863,7 @@ static void sci_shutdown(struct uart_port *port)
 static unsigned int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 				   unsigned long freq)
 {
-	if (s->sampling_rate)
-		return DIV_ROUND_CLOSEST(freq, s->sampling_rate * bps) - 1;
-
-	/* Warn, but use a safe default */
-	WARN_ON(1);
-
-	return ((freq + 16 * bps) / (32 * bps) - 1);
+	return DIV_ROUND_CLOSEST(freq, s->sampling_rate * bps) - 1;
 }
 
 /* calculate frame length from SMR */
-- 
1.9.1

