From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 17 Dec 2018 14:05:09 +0000
Subject: Re: [PATCH v4 0/4] serial: sh-sci: Fix fallback to PIO on DMA failure
Message-Id: <20181217140509.GA7112@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213184444.21904-1-geert+renesas@glider.be>
In-Reply-To: <20181213184444.21904-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jiri Slaby <jslaby@suse.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Dec 13, 2018 at 07:44:40PM +0100, Geert Uytterhoeven wrote:
> 	Hi Greg, Jiri,
> 
> When submitting a DMA request fails, the sh-sci driver is supposed to
> fall back to PIO.  However, this never really worked due to various
> reasons (sh-sci driver issues and dmaengine framework limitations).
> 
> There are three places where DMA submission can fail, and the driver
> should fall back to PIO:
>   1. sci_dma_rx_complete(),
>   2. sci_submit_rx(),
>   3. work_fn_tx().
> 
> This patch series fixes fallback to PIO in the receive path (cases 1 and
> 2).
> Fallback to PIO in the transmit path (case 3) already seems to work
> fine.
> 
> Changes compared to v3:
>   - Let sci_submit_rx() return -EAGAIN instead of -1 on failure,
>   - Check for negative error in sci_submit_rx() caller.

First 3 patches now queued up, thanks.

I'll wait for a respin or something for patch 4.

thanks,

greg k-h
