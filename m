From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 29 Jul 2008 00:05:47 +0000
Subject: Re: [2.6 patch] mm/hugetlb.c must #include <asm/io.h>
Message-Id: <20080729000547.GF28055@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080727130438.GJ9301@cs181140183.pp.htv.fi>
In-Reply-To: <20080727130438.GJ9301@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: Andi Kleen <ak@suse.de>, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, wli@holomorphy.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Sun, Jul 27, 2008 at 04:04:38PM +0300, Adrian Bunk wrote:
> This patch fixes the following build error on sh caused by
> commit aa888a74977a8f2120ae9332376e179c39a6b07d
> (hugetlb: support larger than MAX_ORDER):
> 
> <--  snip  -->
> 
> ...
>   CC      mm/hugetlb.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/mm/hugetlb.c: In function 'alloc_bootmem_huge_page':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/mm/hugetlb.c:958: error: implicit declaration of function 'virt_to_phys'
> make[2]: *** [mm/hugetlb.o] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
Acked-by: Paul Mundt <lethal@linux-sh.org>
