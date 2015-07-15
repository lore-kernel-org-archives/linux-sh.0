From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 15 Jul 2015 20:30:51 +0000
Subject: Re: [PATCH 1/8] serial: sh-sci: Use correct device for DMA mapping with IOMMU
Message-Id: <1503866.L25viQpzPd@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1432145174-11534-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432145174-11534-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wednesday 15 July 2015 13:37:36 Geert Uytterhoeven wrote:
> On Sat, May 23, 2015 at 9:01 PM, Laurent Pinchart wrote:
> > On Wednesday 20 May 2015 20:06:07 Geert Uytterhoeven wrote:
> >> To function correctly in the presence of an IOMMU, the DMA buffers must
> >> be managed using the DMA channel's device instead of the platform
> >> device's device.
> >> 
> >> Make sure to free the DMA memory before releasing the channel, and avoid
> >> freeing it twice (when DMA initialization succeeded before, but failed
> >> partially on next open).
> >> 
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> 
> >>  drivers/tty/serial/sh-sci.c | 17 +++++++++++------
> >>  1 file changed, 11 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> >> index 583aa563d4038f8b..8756d186e86891ac 100644
> >> --- a/drivers/tty/serial/sh-sci.c
> >> +++ b/drivers/tty/serial/sh-sci.c
> >> @@ -1372,10 +1372,13 @@ static void sci_rx_dma_release(struct sci_port
> >> *s, bool enable_pio)
> >> 
> >>       s->chan_rx = NULL;
> >>       s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
> >> 
> >> +     if (sg_dma_address(&s->sg_rx[0])) {
> > 
> > 0 is a valid DMA address. You should use dma_mapping_error() to test for
> 
> 0 is not a valid DMA addresss on sh...

It is on ARM though.

> > invalid addresses. I'm afraid we don't have any API to set a DMA address
> > to an invalid value, but we can probably use DMA_ERROR_CODE for now even
> > if it's limited to ARM.
> 
> There's no DMA_ERROR_CODE on sh.
> 
> Furthermore, while dma_mapping_error() on ARM checks for DMA_ERROR_CODE
> (~0), sh checks for zero...

That's why drivers are supposed to use dma_mapping_error(). The problem is the 
lack of an API to set a DMA address to an invalid value in an architecture-
independent way.

-- 
Regards,

Laurent Pinchart

