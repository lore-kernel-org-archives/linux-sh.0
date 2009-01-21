From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 21 Jan 2009 08:30:11 +0000
Subject: Re: [PATCH] dma: fix up broken comparison in dma_alloc_from_coherent
Message-Id: <20090121083011.GB14537@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60901201348r6a59928dw3fcf8c9c823d5c68@mail.gmail.com> <1232488507.6794.8.camel@localhost.localdomain> <20090121033951.GB14094@linux-sh.org> <20090121081118.GA14537@linux-sh.org> <Pine.LNX.4.64.0901210928010.4407@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0901210928010.4407@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <lg@denx.de>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, Adrian McMenamin <lkmladrian@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-sh <linux-sh@vger.kernel.org>, penberg@cs.helsinki.fi, dbaryshkov@gmail.com, penguin-kernel@i-love.sakura.ne.jp, Johannes Weiner <hannes@cmpxchg.org>

On Wed, Jan 21, 2009 at 09:29:39AM +0100, Guennadi Liakhovetski wrote:
> Nitpick:
> 
> On Wed, 21 Jan 2009, Paul Mundt wrote:
> 
> > +	/*
> > +	 * Memory was found in the per-device arena.
> > +	 */
> 
> s/arena/area/ ?
> 
That was in the original, I'll fix it up before sending it off.
