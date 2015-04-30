From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 30 Apr 2015 16:21:28 +0000
Subject: [PATCH 04/13] serial: sh-sci: Document remaining FIFO Control Register bits
Message-Id: <1430410897-12770-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 2bae842fb0fc0ae6..1586d68470b6f0a2 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -65,9 +65,9 @@ enum {
 #define SCIF_DEFAULT_ERROR_MASK (SCIF_PER | SCIF_FER | SCIF_ER | SCIF_BRK)
 
 /* SCFCR (FIFO Control Register) */
-#define SCFCR_MCE	0x0008
-#define SCFCR_TFRST	0x0004
-#define SCFCR_RFRST	0x0002
+#define SCFCR_MCE	0x0008		/* Modem Control Enable */
+#define SCFCR_TFRST	0x0004		/* Transmit FIFO Data Register Reset */
+#define SCFCR_RFRST	0x0002		/* Receive FIFO Data Register Reset */
 #define SCFCR_LOOP	(1 << 0)	/* Loopback Test */
 
 /* SCSPTR (Serial Port Register), optional */
-- 
1.9.1

