From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Jan 2019 14:48:19 +0000
Subject: Re: [PATCH v5 3/4] serial: sh-sci: Fix fallback to PIO in sci_dma_rx_complete()
Message-Id: <20190108144818.smfgkog62uwbavjc@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20190107162320.15530-1-geert+renesas@glider.be>
 <20190107162320.15530-4-geert+renesas@glider.be>
In-Reply-To: <20190107162320.15530-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Jan 07, 2019 at 05:23:19PM +0100, Geert Uytterhoeven wrote:
> When submitting a DMA request fails in sci_dma_rx_complete(), the driver
> tries to fall back to PIO, but that does not work: no more data will be
> received, or the kernel will even crash.
> 
> Fix this similar as in (but not identical to) sci_submit_rx():
>   - On SCIF, PIO cannot take over if any DMA transactions are pending,
>     hence they must be terminated first.
>   - All active cookies must be invalidated, else rx_timer_fn() may
>     trigger a NULL pointer dereference.
>   - Restarting the port is not needed, as it is already running, but
>     serial port interrupts must be directed back from the DMA engine to
>     the CPU.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
