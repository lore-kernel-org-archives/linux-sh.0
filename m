From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Jan 2019 14:46:45 +0000
Subject: Re: [PATCH v5 2/4] serial: sh-sci: Extract sci_dma_rx_reenable_irq()
Message-Id: <20190108144644.dw2cvqpkpay2anzl@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20190107162320.15530-1-geert+renesas@glider.be>
 <20190107162320.15530-3-geert+renesas@glider.be>
In-Reply-To: <20190107162320.15530-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Jan 07, 2019 at 05:23:18PM +0100, Geert Uytterhoeven wrote:
> Extract the functionality to direct new serial port interrupts back to
> the CPU into its own helper, to prepare for using it from a second
> callsite.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
