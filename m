From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 30 May 2008 03:24:47 +0000
Subject: Re: [2.6 patch] sh/kernel/cpu/irq/intc-sh5.c build fix
Message-Id: <20080530032447.GC13663@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080529220449.GA1763@cs181133002.pp.htv.fi>
In-Reply-To: <20080529220449.GA1763@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 30, 2008 at 01:04:49AM +0300, Adrian Bunk wrote:
> This patch fixes the following build error caused by
> commit a1dc4b59fa4af97ae68ee214d4d72bbd7c7ec1dc
> (sh: intc_sh5 depends on cayman board for IRQ priority table.):
> 
> <--  snip  -->
> 
> ...
>   CC      arch/sh/kernel/cpu/irq/intc-sh5.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/kernel/cpu/irq/intc-sh5.c: In function 'plat_irq_setup':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/kernel/cpu/irq/intc-sh5.c:257: error: expected declaration or statement at end of input
> make[4]: *** [arch/sh/kernel/cpu/irq/intc-sh5.o] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
Applied, thanks Adrian.
