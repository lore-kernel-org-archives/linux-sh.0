From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Aug 2012 07:17:16 +0000
Subject: Re: irqdomain breaks ap4 boot
Message-Id: <20120831071716.GF7014@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Kobayashi-san,

I'd rather only apply patches that are ready for upstream.
Is this patch suitable for merging upstream?

On Fri, Aug 31, 2012 at 03:55:09PM +0900, Tetsuyuki Kobayashi wrote:
> Simon-san,
> 
> This patch may be just a quick fix but could you apply this patch to
> kzm9g branch for convience ?
> 
> 
> (2012/08/10 21:38), Paul Mundt wrote:
> 
> >I screwed up the multi-evt case, it should be trying to associate irq2,
> >not irq. Try this:
> >
> >---
> >
> >diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> >index 32c26d7..8f32a13 100644
> >--- a/drivers/sh/intc/core.c
> >+++ b/drivers/sh/intc/core.c
> >@@ -355,7 +355,7 @@ int __init register_intc_controller(struct intc_desc *desc)
> >  			if (unlikely(res)) {
> >  				if (res = -EEXIST) {
> >  					res = irq_domain_associate(d->domain,
> >-								   irq, irq);
> >+								   irq2, irq2);
> >  					if (unlikely(res)) {
> >  						pr_err("domain association "
> >  						       "failure\n");
> >
> 
