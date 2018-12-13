From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 13 Dec 2018 18:44:40 +0000
Subject: [PATCH v4 0/4] serial: sh-sci: Fix fallback to PIO on DMA failure
Message-Id: <20181213184444.21904-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Greg, Jiri,

When submitting a DMA request fails, the sh-sci driver is supposed to
fall back to PIO.  However, this never really worked due to various
reasons (sh-sci driver issues and dmaengine framework limitations).

There are three places where DMA submission can fail, and the driver
should fall back to PIO:
  1. sci_dma_rx_complete(),
  2. sci_submit_rx(),
  3. work_fn_tx().

This patch series fixes fallback to PIO in the receive path (cases 1 and
2).
Fallback to PIO in the transmit path (case 3) already seems to work
fine.

Changes compared to v3:
  - Let sci_submit_rx() return -EAGAIN instead of -1 on failure,
  - Check for negative error in sci_submit_rx() caller.

Changes compared to v2:
  - Add missing definition of "u16 scr" to sci_dma_rx_complete(),
  - Move label handle_pio inside #ifdef to kill defined but not used
    compiler warning when CONFIG_SERIAL_SH_SCI_DMA=n,
  - Move call to dmaengine_terminate_async() in sci_dma_rx_complete()
    inside the spinlock, for symmetry with sci_submit_rx(),
  - Move the call sci_submit_rx() in sci_rx_interrupt() up, as it may
    fail, rendering the modification of scr unused,
  - Split in multiple patches,
  - Drop RFC status.

Changes compared to v1:
  - Fix fallback in sci_dma_rx_complete(),
  - Fallback in the transmit path already works fine,
  - Widen audience, but keep RFC.

This has been tested on r8a7791/koelsch, using SCIF1 on debug serial 1,
and SCIFA3 on EXIO-B, by introducing random failures in DMA submission
code.

Thanks!

Geert Uytterhoeven (4):
  serial: sh-sci: Fix locking in sci_submit_rx()
  serial: sh-sci: Fix crash in rx_timer_fn() on PIO fallback
  serial: sh-sci: Resume PIO in sci_rx_interrupt() on DMA failure
  serial: sh-sci: Fix fallback to PIO in sci_dma_rx_complete()

 drivers/tty/serial/sh-sci.c | 39 +++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
