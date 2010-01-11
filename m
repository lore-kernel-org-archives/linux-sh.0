From: "Pietrek, Markus" <Markus.Pietrek@emtrion.de>
Date: Mon, 11 Jan 2010 12:46:16 +0000
Subject: [PATCH] sh-sci: fixed serial driver not waiting for last character
Message-Id: <95F51F4B902CAC40AF459205F6322F015EFBC7CD2F@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The flag TEND used by sci_tx_empty() is self-clearing only on SCIFA but not on SCIF. Therefore the driver will shut down the device even when there are still characters left for transmission.

It can be easily reproduced on the SH7723 with
echo "Hello world" >/dev/ttySC2
The receiver gets only "Hellb"

This patch fixes it.

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 3d0b0ee..e218000 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -352,6 +352,9 @@ static void sci_transmit_chars(struct uart_port *port)
        else
                count = scif_txroom(port);

+       if (port->type = PORT_SCIF)
+               sci_out(port, SCxSR, SCxSR_TEND_CLEAR(port));
+
        do {
                unsigned char c;

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 0efcded..1e9c44b 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -271,6 +271,7 @@
 # define SCxSR_ERROR_CLEAR(port) (((port)->type = PORT_SCI) ? 0xc4 : 0x0073)
 # define SCxSR_TDxE_CLEAR(port)  (((port)->type = PORT_SCI) ? 0x78 : 0x00df)
 # define SCxSR_BREAK_CLEAR(port) (((port)->type = PORT_SCI) ? 0xc4 : 0x00e3)
+# define SCxSR_TEND_CLEAR(port)  (0x00bf)
 #endif

 /* SCFCR */

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or otherwise confidential information.
- If you have received this e-mail in error, you are hereby notified that any review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
