From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Aug 2008 06:02:19 +0000
Subject: Re: [2.6 patch] fix SH7705_CACHE_32KB compilation
Message-Id: <20080806060219.GA2610@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080805153711.GA22895@cs181140183.pp.htv.fi>
In-Reply-To: <20080805153711.GA22895@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 05, 2008 at 06:37:11PM +0300, Adrian Bunk wrote:
> This patches compile errors like the following caused by
> commit 51f3547d619956e9b428bfff17004d8f4d259a02
> (sh: Allow SH-3 and SH-5 to use common headers):
> 
> <--  snip  -->
> 
> ...
>   CC      arch/sh/mm/init.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/mm/init.c: In function 'mem_init':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/mm/init.c:232: error: implicit declaration of function 'p3_cache_init'
> make[2]: *** [arch/sh/mm/init.o] Error 1
> make[1]: *** [arch/sh/mm] Error 2
> ...
>   CC      kernel/fork.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/kernel/fork.c: In function 'dup_mmap':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/kernel/fork.c:323: error: implicit declaration of function 'flush_dcache_mmap_lock'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/kernel/fork.c:325: error: implicit declaration of function 'flush_dcache_mmap_unlock'
> make[2]: *** [kernel/fork.o] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
Applied, thanks.
