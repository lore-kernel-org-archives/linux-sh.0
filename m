From: Julia Lawall <julia.lawall@lip6.fr>
Date: Thu, 03 Jan 2013 09:40:20 +0000
Subject: clk dereference in arch/sh/kernel/cpufreq.c
Message-Id: <alpine.DEB.2.02.1301031038030.1989@hadrien>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

There has been a discussion recently about how the result of get_clk
should be an opaque handle, not a value that can be dereferenced:

https://lkml.org/lkml/2012/12/20/105

There is such a dereference in arch/sh/kernel/cpufreq.c, in the function
sh_cpufreq_cpu_init:

freq_table = cpuclk->nr_freqs ? cpuclk->freq_table : NULL;

It was not obvious to me, however, what API function should be used
instead, so I am just reporting the (potential) problem.

thanks,
julia
