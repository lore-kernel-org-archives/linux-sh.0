From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Date: Wed, 07 Nov 2012 06:59:24 +0000
Subject: [PATCH 05/10] serial: sh-sci: fix condition test to set SCBRR
Message-Id: <509A06CC.5080302@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <509A0658.1010503@renesas.com>
In-Reply-To: <509A0658.1010503@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

SCBRR = 0 is valid value (divide by 1).

Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e65e546..ffeca65 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1853,7 +1853,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	dev_dbg(port->dev, "%s: SMR %x, t %x, SCSCR %x\n", __func__, smr_val, t,
 		s->cfg->scscr);
 
-	if (t > 0) {
+	if (t >= 0) {
 		if (t >= 256) {
 			serial_port_out(port, SCSMR, (serial_port_in(port, SCSMR) & ~3) | 1);
 			t >>= 2;
-- 
1.7.12.4

