From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 08 Oct 2015 14:22:01 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Wait for IRQs completion when freeing channel
Message-Id: <2421567.ZFdiTCl9SH@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

On Monday 05 October 2015 15:11:55 Vinod Koul wrote:
> On Tue, Sep 15, 2015 at 12:11:33AM +0000, Kuninori Morimoto wrote:
> > Hi Laurent
> > 
> > > When freeing channel resources we need to ensure that no IRQ will occur
> > > for the given channel. In order to do so the driver stops the hardware,
> > > but an IRQ handler could still be running, especially given that the
> > > channel IRQ is threaded. Fix it by waiting for pending IRQs completion
> > > with synchronize_irq()
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  drivers/dma/sh/rcar-dmac.c | 37 +++++++++++++++++++------------------
> > >  1 file changed, 19 insertions(+), 18 deletions(-)
> > > 
> > > Hi Morimoto-san,
> > > 
> > > This patch is compile-tested only. Would you be able to check if it
> > > fixes the issue you've reported with SDHI and rcar-dmac ?
> > 
> > Thanks. I will ask to BSP team
> 
> Patch looks okay, but if we get this confirmation it would be great.

I've just received a report that the patch has been successfully tested to get 
rid of the oops, but it introduced another issue in that synchronize_irq() 
gets called from non-sleeptable context through terminate_all(). 

The DMA engine API states that

   * device_terminate_all
     - Aborts all the pending and ongoing transfers on the channel
     - This command should operate synchronously on the channel,
       terminating right away all the channels

I wonder how to interpret "synchronously" here, should terminate_all() wait 
for termination to be complete ? In that case it wouldn't be valid to call it 
from non-sleepable context.

-- 
Regards,

Laurent Pinchart

