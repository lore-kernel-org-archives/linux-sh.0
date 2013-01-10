From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 10 Jan 2013 08:59:24 +0000
Subject: Re: clk dereference in arch/sh/kernel/cpufreq.c
Message-Id: <20130110085923.GA7785@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.02.1301031038030.1989@hadrien>
In-Reply-To: <alpine.DEB.2.02.1301031038030.1989@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 03, 2013 at 10:40:20AM +0100, Julia Lawall wrote:
> There has been a discussion recently about how the result of get_clk
> should be an opaque handle, not a value that can be dereferenced:
> 
> https://lkml.org/lkml/2012/12/20/105
> 
> There is such a dereference in arch/sh/kernel/cpufreq.c, in the function
> sh_cpufreq_cpu_init:
> 
> freq_table = cpuclk->nr_freqs ? cpuclk->freq_table : NULL;
> 
> It was not obvious to me, however, what API function should be used
> instead, so I am just reporting the (potential) problem.
> 
In this case we would have to add some new API for fetching the frequency
table associated with the struct clk, which is reasonably
straightforward. It's not obvious how a private API vs deref of a type we
have a private definition for is any better or worse, though. This code
is not aimed at the common struct clk in any event.
