From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Aug 2012 01:14:41 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <87wr0us6tg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

Thank you for your patch

> > diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> > index 32c26d7..8f32a13 100644
> > --- a/drivers/sh/intc/core.c
> > +++ b/drivers/sh/intc/core.c
> > @@ -355,7 +355,7 @@ int __init register_intc_controller(struct intc_desc *desc)
> >   			if (unlikely(res)) {
> >   				if (res = -EEXIST) {
> >   					res = irq_domain_associate(d->domain,
> > -								   irq, irq);
> > +								   irq2, irq2);
> >   					if (unlikely(res)) {
> >   						pr_err("domain association "
> >   						       "failure\n");
> 
> I tried this patch but there is still the same error.
> I checked quickly by debugger, and I found the failing 
> irq_domain_associate() is not called here (line 357) but the one at line 
> 328.

But, I got same result.

This WARNING is indicating
> intc: domain association failure    
      
So, as kobayashi-san said, 
it has happend on previous irq_domain_associate(), not here.

Best regards
---
Kuninori Morimoto
