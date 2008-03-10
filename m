From: Yutaro Ebihara <ebiharaml@si-linux.com>
Date: Mon, 10 Mar 2008 09:13:19 +0000
Subject: SH7760,7780,7785 sh-sci.c bugfix
Message-Id: <24C8828EFB268Eebiharaml@si-linux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

hi all

I found bug in sh-sci.c

    $ echo "A" > /dev/ttySC[0-2]           open()
                                           write()
                                           close()

    send more than 128 bytes into  ttySC[0-2] from other machine.

    $ echo "A"  > /dev/ttySC[0-2]          open()

    kernel stoped.


Because.

SCRFDR counts upto 0x80 not 0x7F.
if recive fifo has 128 charactors, SCRFDR indicates 0x80.

               return sci_in(port, SCRFDR) & 0x7f;

this code returns zero , so ISR 's never finished.





--- linux-2.6.24_cat/drivers/serial/sh-sci.c-old        2008-03-06 19:
40:13.000000000 +0900
+++ linux-2.6.24_cat/drivers/serial/sh-sci.c    2008-03-06 19:40:27.
000000000 +0900
@@ -412,12 +412,12 @@
     defined(CONFIG_CPU_SUBTYPE_SH7785)
 static inline int scif_txroom(struct uart_port *port)
 {
-       return SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0x7f);
+       return SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0xff);
 }

 static inline int scif_rxroom(struct uart_port *port)
 {
-       return sci_in(port, SCRFDR) & 0x7f;
+       return sci_in(port, SCRFDR) & 0xff;
 }
 #else
 static inline int scif_txroom(struct uart_port *port)
 
 
