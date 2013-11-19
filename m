From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 19 Nov 2013 14:02:03 +0000
Subject: [PATCH v3 02/29] serial: sh-sci: Remove baud rate calculation algorithm 5
Message-Id: <1384869751-9786-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>

The algorithm isn't used, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 2 --
 include/linux/serial_sci.h  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 280753f..2fc1a0e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1820,8 +1820,6 @@ static unsigned int sci_scbrr_calc(unsigned int algo_id, unsigned int bps,
 		return (((freq * 2) + 16 * bps) / (16 * bps) - 1);
 	case SCBRR_ALGO_4:
 		return (((freq * 2) + 16 * bps) / (32 * bps) - 1);
-	case SCBRR_ALGO_5:
-		return (((freq * 1000 / 32) / bps) - 1);
 	}
 
 	/* Warn, but use a safe default */
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index d340497..803068d 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -15,7 +15,6 @@ enum {
 	SCBRR_ALGO_2,		/* ((clk + 16 * bps) / (32 * bps) - 1) */
 	SCBRR_ALGO_3,		/* (((clk * 2) + 16 * bps) / (16 * bps) - 1) */
 	SCBRR_ALGO_4,		/* (((clk * 2) + 16 * bps) / (32 * bps) - 1) */
-	SCBRR_ALGO_5,		/* (((clk * 1000 / 32) / bps) - 1) */
 	SCBRR_ALGO_6,		/* HSCIF variable sample rate algorithm */
 };
 
-- 
1.8.3.2

