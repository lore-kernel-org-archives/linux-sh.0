From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 15 Mar 2012 06:14:50 +0000
Subject: Re: [PATCH 4/7] arch/sh/drivers/dma/{dma-g2,dmabrg}.c: ensure arguments to request_irq and free_irq
Message-Id: <20120315061450.GC10046@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1331494587-12196-1-git-send-email-Julia.Lawall@lip6.fr> <1331494587-12196-5-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1331494587-12196-5-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 11, 2012 at 08:36:24PM +0100, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Convert calls to free_irq so that the second argument is the same as the
> last argument of the corresponding call to request_irq.  Without this
> property, free_irq does nothing.
> 
> In the case of dmabrg.c the change is merely cosmetic - changing 0 to NULL.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
Applied, thanks.
