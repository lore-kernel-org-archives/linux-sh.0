From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 05 Sep 2018 13:11:25 +0000
Subject: [PATCH qemu v2] hw/char/sh_serial: Add timeout handling to unbreak serial input
Message-Id: <20180905131125.12635-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Ulrich Hecht <uli@fpond.eu>, Rob Landley <rob@landley.net>, Rich Felker <dalias@libc.org>, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

As of commit 18e8cf159177100e ("serial: sh-sci: increase RX FIFO trigger
defaults for (H)SCIF") in Linux v4.11-rc1, the serial console on the
QEMU SH4 target is broken: it delays serial input until enough data has
been received.

Since aforementioned commit, the Linux SCIF driver programs the Receive
FIFO Data Count Trigger bits in the FIFO Control Register, to postpone
generating a receive interrupt until:
  1. At least the receive trigger count of bytes of data are available
     in the receive FIFO, OR
  2. No further data has been received for at least 15 etu after the
     last received data.

While QEMU implements the former, it does not implement the latter.
Hence the receive interrupt is not generated until the former condition
is met.

Fix this by adding basic timeout handling.  As the QEMU SCIF emulation
ignores any serial speed programming, the timeout value used conforms to
a default speed of 9600 bps, which is fine for any interactive console.

Reported-by: Rob Landley <rob@landley.net>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <uli@fpond.eu>
Tested-by: Rob Landley <rob@landley.net>
Tested-by: Rich Felker <dalias@libc.org>
---
v2:
  - Add Tested-by,
  - Fix spelling in patch description.
---
 hw/char/sh_serial.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 373a40595fd975d1..12831561a6c8b137 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -29,6 +29,7 @@
 #include "hw/sh4/sh.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
+#include "qemu/timer.h"
 
 //#define DEBUG_SERIAL
 
@@ -63,6 +64,8 @@ typedef struct {
     int rtrg;
 
     CharBackend chr;
+    QEMUTimer *fifo_timeout_timer;
+    uint64_t etu; /* Elementary Time Unit (ns) */
 
     qemu_irq eri;
     qemu_irq rxi;
@@ -314,6 +317,16 @@ static int sh_serial_can_receive1(void *opaque)
     return sh_serial_can_receive(s);
 }
 
+static void sh_serial_timeout_int(void *opaque)
+{
+    sh_serial_state *s = opaque;
+
+    s->flags |= SH_SERIAL_FLAG_RDF;
+    if (s->scr & (1 << 6) && s->rxi) {
+        qemu_set_irq(s->rxi, 1);
+    }
+}
+
 static void sh_serial_receive1(void *opaque, const uint8_t *buf, int size)
 {
     sh_serial_state *s = opaque;
@@ -330,8 +343,12 @@ static void sh_serial_receive1(void *opaque, const uint8_t *buf, int size)
                 if (s->rx_cnt >= s->rtrg) {
                     s->flags |= SH_SERIAL_FLAG_RDF;
                     if (s->scr & (1 << 6) && s->rxi) {
+                        timer_del(s->fifo_timeout_timer);
                         qemu_set_irq(s->rxi, 1);
                     }
+                } else {
+                    timer_mod(s->fifo_timeout_timer,
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 15 * s->etu);
                 }
             }
         }
@@ -402,6 +419,9 @@ void sh_serial_init(MemoryRegion *sysmem,
                                  sh_serial_event, NULL, s, NULL, true);
     }
 
+    s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                         sh_serial_timeout_int, s);
+    s->etu = NANOSECONDS_PER_SECOND / 9600;
     s->eri = eri_source;
     s->rxi = rxi_source;
     s->txi = txi_source;
-- 
2.17.1
