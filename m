From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Jan 2012 02:00:32 +0000
Subject: Re: [RFC][PATCH 1/3] dmaengine: shdma: add .no_error_irq flag
Message-Id: <20120109020031.GI25648@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0537F2.4080306@renesas.com>
In-Reply-To: <4F0537F2.4080306@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 06, 2012 at 01:00:25PM +0900, Shimoda, Yoshihiro wrote:
> Hello Guennadi-san,
> 
> Thank you very much for your review and suggestion.
> I think that your suggestion is very good.
> 
> So, I could remove the no_error_irq flag using platform_get_irq_byname().
> My modified patch is the following. And, if it is no problem,
> I will submit it again:
> -------
> Subject: [PATCH] dmaengine: shdma: modify the DMAC Address Error registration
> 
> The USB-DMAC/SUDMAC don't have the interrupt of DMAC Address Error.
> So, only when the resource has a name and it is "error_irq", the driver
> calls request_irq() for DMAC Address Error.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

If we're going to do this it would be nice to adopt the same behaviour
for the generic DMAE IRQ, too (then we can finally get rid of those silly
CPU_SH4 || ARCH_SHMOBILE ifdefs).

This approach looks like an improvement to me at least.
