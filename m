From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Jun 2018 14:25:13 +0000
Subject: [PATCH 4/4] serial: sh-sci: Stop RX FIFO timer during port shutdown
Message-Id: <20180629142513.20743-8-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The RX FIFO timer may be armed when the port is shut down, hence the
timer function may still be called afterwards.

Fix this race condition by deleting the timer during port shutdown.

Fixes: 039403765e5da3c6 ("serial: sh-sci: SCIFA/B RX FIFO software timeout")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested with scifa0 on r8a7740/armadillo, after

    echo 2000 > /sys/devices/platform/e6c40000.serial/rx_fifo_timeout
---
 drivers/tty/serial/sh-sci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 58016386558c6789..cca3bbc62a6b1110 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2571,6 +2571,8 @@ static void sci_shutdown(struct uart_port *port)
 	}
 #endif
 
+	if (s->rx_trigger > 1 && s->rx_fifo_timeout > 0)
+		del_timer_sync(&s->rx_fifo_timer);
 	sci_free_irq(s);
 	sci_free_dma(port);
 }
-- 
2.17.1

