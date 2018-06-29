From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Jun 2018 14:25:06 +0000
Subject: [PATCH 0/3] serial: sh-sci: Fix port shutdown DMA race conditions
Message-Id: <20180629142513.20743-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

This patch series fixes race conditions between DMA use and port
shutdown on Renesas "SCIF" serial ports, causing e.g.

    sh-sci e6550000.serial: Failed preparing Tx DMA descriptor
    Unable to handle kernel read from unreadable memory at virtual address 0000000000000000
    ...
    Call trace:
     sci_tx_dma_release+0x50/0xfc
     work_fn_tx+0x128/0x22c
     process_one_work+0x394/0x62c
     worker_thread+0x21c/0x324
     kthread+0x118/0x128
     ret_from_fork+0x10/0x18

I have no guaranteed way to reproducis this issue. I see it sometimes
when doing a partial login on a port running getty, and letting getty
time out.

The first two patches simplify DMA release handling, and make sure the
work function is not called after port shutdown.
The last patch switches the driver to the new
dmaengine_terminate_(a)sync() functions, now DMA release is done from a
single point.

Please review. Thanks!

Geert Uytterhoeven (3):
  serial: sh-sci: Postpone DMA release when falling back to PIO
  serial: sh-sci: Stop TX DMA workqueue during port shutdown
  serial: sh-sci: Stop using deprecated dmaengine_terminate_all()

 drivers/tty/serial/sh-sci.c | 93 +++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
