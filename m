From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 14 Apr 2009 04:34:52 +0000
Subject: [PATCH] sh-sci: fix SCBRR value calculation
Message-Id: <ud4bf3jpm.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
>> Iwamatsu-san

Please check this patch to make sure it doesn't break any boards. 
I checked this patch by AP325 (for SCIFA)
and Diamond Head (for SCIF)
It works well
But I don't know about some strange Hitachi ULSI board with magical clock settings.

 drivers/serial/sh-sci.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index d0aa82d..f8c0b87 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -761,9 +761,9 @@ static inline int sci_rxd_in(struct uart_port *port)
 static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
 {
 	if (port->type = PORT_SCIF)
-		return (clk+16*bps)/(32*bps)-1;
+		return (clk/(32*bps)) - 1;
 	else
-		return ((clk*2)+16*bps)/(16*bps)-1;
+		return ((clk*2)/(16*bps)) - 1;
 }
 #define SCBRR_VALUE(bps, clk) scbrr_calc(port, bps, clk)
 #elif defined(__H8300H__) || defined(__H8300S__)
-- 
1.5.6.3

