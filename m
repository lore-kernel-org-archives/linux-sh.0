From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 06 Oct 2010 13:41:32 +0000
Subject: Re: [PATCH 1/7] perf: Add helper function to return number of
Message-Id: <1286372492.2144.181.camel@laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1286222593.git.matt@console-pimps.org>
	 <c4eb88b09da564fe093cc6571ed747971425e69a.1286222593.git.matt@console-pimps.org>
	 <20101006121410.GK13563@erda.amd.com>
In-Reply-To: <20101006121410.GK13563@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Richter <robert.richter@amd.com>
Cc: Matt Fleming <matt@console-pimps.org>, Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>

On Wed, 2010-10-06 at 14:14 +0200, Robert Richter wrote:
> > +int perf_num_counters(void)
> > +{
> > +     return armpmu_get_max_events();
> > +}
> > +EXPORT_SYMBOL_GPL(perf_num_counters);
> 
> Peter,
> 
> can you please ack this interface? 

It does seem like the best way forward for this, so

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>


