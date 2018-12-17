From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 13:25:24 +0000
Subject: Re: [PATCH v4 3/4] serial: sh-sci: Resume PIO in sci_rx_interrupt() on DMA failure
Message-Id: <20181217132523.zqoqtebobcs4oajt@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213184444.21904-1-geert+renesas@glider.be>
 <20181213184444.21904-4-geert+renesas@glider.be>
In-Reply-To: <20181213184444.21904-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Dec 13, 2018 at 07:44:43PM +0100, Geert Uytterhoeven wrote:
> On (H)SCIF, sci_submit_rx() is called in the receive interrupt handler.
> Hence if DMA submission fails, the interrupt handler should resume
> handling reception using PIO, else no more data is received.
> 
> Make sci_submit_rx() return an error indicator, so the receive interrupt
> handler can act appropriately.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
