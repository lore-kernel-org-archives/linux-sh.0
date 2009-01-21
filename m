From: Guennadi Liakhovetski <lg@denx.de>
Date: Wed, 21 Jan 2009 08:29:39 +0000
Subject: Re: [PATCH] dma: fix up broken comparison in dma_alloc_from_coherent
Message-Id: <Pine.LNX.4.64.0901210928010.4407@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60901201348r6a59928dw3fcf8c9c823d5c68@mail.gmail.com>
 <1232488507.6794.8.camel@localhost.localdomain> <20090121033951.GB14094@linux-sh.org>
 <20090121081118.GA14537@linux-sh.org>
In-Reply-To: <20090121081118.GA14537@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, Adrian McMenamin <lkmladrian@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-sh <linux-sh@vger.kernel.org>, penberg@cs.helsinki.fi, dbaryshkov@gmail.com, penguin-kernel@i-love.sakura.ne.jp, Johannes Weiner <hannes@cmpxchg.org>

Nitpick:

On Wed, 21 Jan 2009, Paul Mundt wrote:

> +	/*
> +	 * Memory was found in the per-device arena.
> +	 */

s/arena/area/ ?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.

DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
