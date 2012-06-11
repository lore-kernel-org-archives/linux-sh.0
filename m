From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Jun 2012 03:25:47 +0000
Subject: Re: [PATCH 2/2] irqdomain: Support for static IRQ mapping and association.
Message-Id: <20120611032547.GB10170@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1337576792-5347-1-git-send-email-lethal@linux-sh.org>
 <1337576792-5347-2-git-send-email-lethal@linux-sh.org>
 <20120526015049.1616D3E2336@localhost>
In-Reply-To: <20120526015049.1616D3E2336@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 25, 2012 at 07:50:49PM -0600, Grant Likely wrote:
> On Mon, 21 May 2012 14:06:32 +0900, Paul Mundt <lethal@linux-sh.org> wrote:
> > +int irq_create_strict_mappings(struct irq_domain *domain, unsigned int irq_base,
> > +			       irq_hw_number_t hwirq_base, int count)
> > +{
> > +	int ret;
> > +
> > +	ret = irq_alloc_descs(irq_base, irq_base, count,
> > +			      of_node_to_nid(domain->of_node));
> > +	if (unlikely(ret < 0))
> > +		return ret;
> > +
> > +	ret = irq_domain_associate_many(domain, irq_base, hwirq_base, count);
> > +	if (unlikely(ret < 0)) {
> > +		irq_free_descs(irq_base, count);
> > +		return ret;
> > +	}
> 
> It would be really good to make sure the hwirqs aren't already
> associated before trying to associate them again.  Unfortunately that
> can't be done (nicely) until I get rid of the slow path lookup.  I've
> got a patch for that which I'll rebase on top of this one and post soon.
> 
Any updates on this? I have quite a few more changes I intend on making,
but there's no point in starting in on that until these existing patches
are sorted out.
