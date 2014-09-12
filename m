From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 12 Sep 2014 08:51:45 +0000
Subject: [RFC 0/3] serial: sh-sci: SCIF FIFO exploitation
Message-Id: <1410511908-9282-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org
Cc: horms@verge.net.au, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

The current sh-sci implementation doesn't exploit the RX FIFOs at all and
has the chip issue an interrupt for every byte received.  This series
implements the necessary changes to improve that.

It includes a sysfs interface for changing the FIFO trigger level; there
seem to be few drivers that implement something like that (I only found
one), so I'd like to know if this implementation is palatable.

CU
Uli


Ulrich Hecht (3):
  serial: sh-sci: consider DR (data ready) bit adequately
  serial: sh-sci: exploit RX FIFOs better
  serial: sh-sci: make RX FIFO trigger tunable via sysfs

 drivers/tty/serial/sh-sci.c | 113 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/tty/serial/sh-sci.h |   5 ++
 include/linux/serial_sci.h  |   2 +
 3 files changed, 116 insertions(+), 4 deletions(-)

-- 
1.8.4.5

