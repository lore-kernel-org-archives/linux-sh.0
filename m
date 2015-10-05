From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 05 Oct 2015 14:11:55 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Wait for IRQs completion when freeing channel
Message-Id: <20151005141154.GB13501@vkoul-mobl.iind.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 15, 2015 at 12:11:33AM +0000, Kuninori Morimoto wrote:
> 
> Hi Laurent
> 
> > When freeing channel resources we need to ensure that no IRQ will occur
> > for the given channel. In order to do so the driver stops the hardware,
> > but an IRQ handler could still be running, especially given that the
> > channel IRQ is threaded. Fix it by waiting for pending IRQs completion
> > with synchronize_irq()
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  drivers/dma/sh/rcar-dmac.c | 37 +++++++++++++++++++------------------
> >  1 file changed, 19 insertions(+), 18 deletions(-)
> > 
> > Hi Morimoto-san,
> > 
> > This patch is compile-tested only. Would you be able to check if it fixes the
> > issue you've reported with SDHI and rcar-dmac ?
> 
> Thanks. I will ask to BSP team

Patch looks okay, but if we get this confirmation it would be great.

-- 
~Vinod
