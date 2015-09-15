From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Sep 2015 00:11:33 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Wait for IRQs completion when freeing channel
Message-Id: <87h9mw4kav.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> When freeing channel resources we need to ensure that no IRQ will occur
> for the given channel. In order to do so the driver stops the hardware,
> but an IRQ handler could still be running, especially given that the
> channel IRQ is threaded. Fix it by waiting for pending IRQs completion
> with synchronize_irq()
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/dma/sh/rcar-dmac.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> Hi Morimoto-san,
> 
> This patch is compile-tested only. Would you be able to check if it fixes the
> issue you've reported with SDHI and rcar-dmac ?

Thanks. I will ask to BSP team
