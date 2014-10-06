From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Oct 2014 01:55:40 +0000
Subject: Re: [PATCH] serial: sh-sci: submit rx dma the way the DMA driver can handle it
Message-Id: <20141006015540.GD22040@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1412266448-20266-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1412266448-20266-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 02, 2014 at 06:14:08PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> The shdmac driver has a problem when one wants to submit two RX
> descriptors and then use issue_pending on both (like this driver does):
> 
> Submit first desc
> -> channel state after: SHDMA_PM_ESTABLISHED
> 
> Submit second desc
> -> channel state after: SHDMA_PM_PENDING
> 
> PENDING here means: "Oh, we will wait until the first desc is finished
> and then the second desc will be grabbed from the list anyhow"
> 
> However, because issue_pending does nothing for states !> SHDMA_PM_ESTABLISHED, nothing ever gets active :(
> 
> Since the DMA driver is probably replaced soon anyhow, I decided for the
> least intrusive workaround which is to use issue_pending on every RX
> desc. (Yes, setting s->active_rx twice is ugly).
> 
> Probably not for upstream! However, this patch restores DMA capability
> for SCIFA on my Lager board. Sadly, not for SCIF due to interrupt
> problems still to be investigated.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

sh-sci patches usually go via linux-serial@vger.kernel.org and
Greg Kroah-Hartman <gregkh@linuxfoundation.org>. Could you repost this patch
with those parties included?

> ---
> 
> Some more words about the not working SCIF:
> 
> Once I submit the RX descriptor, I don't get any irq anymore (which the driver
> needs to detect timeouts). Before that, I got them.
> 
> SCIFA has a bit (SCSCR_RDRQE) to select if the interrupt should go to the CPU
> or DMAC and the driver handles this correctly, so DMA works again.
> 
> Plain SCIF does not have such a bit. The documentation has a chapter "SCIF
> Interrupt Sources and the DMAC" (chapter 51.4 here in v0.9) which is a little
> vague to me. But from what I understand, I should get an irq along with the
> DMAC transferring data. The implementation of this driver shows that earlier SH
> hardware worked this way. However, I don't get interrupts, so the timeout
> mechanism fails. DMA works partly, you can receive in 32 bytes chunks only. If
> you are happy with that, you can also use SCIF. Good practice for your typing
> skills ;)
> 
> So, my SCIF->SCIFA patch becomes more useful, too.
> 
>  drivers/tty/serial/sh-sci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index b11819bc95c4..f23b4d2ab51f 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1365,16 +1365,18 @@ static void sci_submit_rx(struct sci_port *s)
>  			}
>  			dev_warn(s->port.dev,
>  				 "failed to re-start DMA, using PIO\n");
> +
> +			chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
>  			sci_rx_dma_release(s, true);
>  			return;
>  		}
> +
> +		s->active_rx = s->cookie_rx[0];
> +
> +		dma_async_issue_pending(chan);
>  		dev_dbg(s->port.dev, "%s(): cookie %d to #%d\n",
>  			__func__, s->cookie_rx[i], i);
>  	}
> -
> -	s->active_rx = s->cookie_rx[0];
> -
> -	dma_async_issue_pending(chan);
>  }
>  
>  static void work_fn_rx(struct work_struct *work)
> -- 
> 2.0.0
> 
