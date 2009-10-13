From: Valentin R Sitsikov <valentin.sitdikov@siemens.com>
Date: Tue, 13 Oct 2009 12:44:19 +0000
Subject: Re: Possibly icahe/dcache synchronization problem on sh7785lcr
Message-Id: <4AD47623.3050804@siemens.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4ACF32C2.9010501@siemens.com>
In-Reply-To: <4ACF32C2.9010501@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I have just tried the patch below.
The result is the following:

Starting D-BUS session bus daemon
Starting Sapwood image server
[   26.060000] Unable to handle kernel NULL pointer dereference at 
virtual address 00000008
[   26.060000] pc = 88394112
[   26.060000] *pde = 8f2e8000
[   26.060000] Oops: 0001 [#1]
[   26.060000] Modules linked in:
[   26.060000]
[   26.060000] Pid : 1326, Comm:                sapwood-server
[   26.060000] CPU : 0                  Not tainted  
(2.6.32-rc3-00376-g28ef99d-dirty #248)
[   26.060000]
[   26.060000] PC is at 0x88394112
[   26.060000] PR is at sh4_flush_dcache_page+0x94/0x168
[   26.060000] PC  : 88394112 SP  : 8f311cf0 SR  : 400080f0 TEA : 00000008
[   26.060000] R0  : 00002000 R1  : 00000008 R2  : 0fffc000 R3  : 00002008
[   26.060000] R4  : 00000008 R5  : 0fffc000 R6  : 00000002 R7  : 00002000
[   26.060000] R8  : 00000000 R9  : 0fffc000 R10 : 8e8548c4 R11 : 0000001e
[   26.060000] R12 : 8e854828 R13 : 880ef0b4 R14 : 8f311cf0
[   26.060000] MACH: 10623cb3 MACL: 00000000 GBR : 00000000 PR  : 88010a30
[   26.060000]
[   26.060000] Call trace:
[   26.060000]  [<8800fc8e>] flush_dcache_page+0x1a/0x4c
[   26.060000]  [<8801099c>] sh4_flush_dcache_page+0x0/0x168
[   26.060000]  [<880ef198>] readpage_async_filler+0xe4/0x150
[   26.060000]  [<880529a2>] read_cache_pages+0x5a/0xc0
[   26.060000]  [<880eee2a>] nfs_readpages+0xfa/0x1bc
[   26.060000]  [<880ef838>] nfs_pagein_multi+0x0/0x138
[   26.060000]  [<880524ae>] __do_page_cache_readahead+0x11e/0x1cc
[   26.060000]  [<88052576>] ra_submit+0x1a/0x28
[   26.060000]  [<8804d12a>] filemap_fault+0x19e/0x384
[   26.060000]  [<8805d0a0>] __do_fault+0x58/0x3b0
[   26.060000]  [<8805de16>] handle_mm_fault+0x362/0x78c
[   26.060000]  [<88010fb0>] do_page_fault+0xf8/0x358
[   26.060000]  [<880630be>] do_mmap_pgoff+0x2ae/0x304
[   26.060000]  [<88171536>] __up_write+0xee/0x130
[   26.060000]  [<880300c2>] up_write+0xa/0x18
[   26.060000]  [<88007d92>] old_mmap+0x82/0xb4
[   26.060000]  [<8800a0ec>] ret_from_exception+0x0/0x8
[   26.060000]  [<8800a0ec>] ret_from_exception+0x0/0x8
[   26.060000]  [<8800a0ec>] ret_from_exception+0x0/0x8
[   26.060000]
[   26.060000] Process: sapwood-server (pid: 1326, stack limit = 8f310001)
[   26.060000] Stack: (0x8f311cf0 to 0x8f312000)
[   26.060000] 1ce0:                                     8f311cf4 
8800fc8e 8f311d0c 8f311d88
[   26.060000] 1d00: 88493fc0 88493fc0 8801099c 880ef198 8f311d1c 
8f266b40 00001e20 880529a2
[   26.060000] 1d20: 8f311d38 8f311d88 00000000 8e8548c4 8f311db8 
88493fc0 880eee2a 8f311d58
[   26.060000] 1d40: 8f311d50 ffffff8c 00001000 8e854828 8f2ecc80 
8f311d58 8f311db8 8e8548c4
[   26.060000] 1d60: 8f2669c0 8f2669c0 0000c000 00002000 00001000 
00000000 8e854828 880ef838
[   26.060000] 1d80: 00000000 00000000 8f311d60 8f2f48c0 880524ae 
8f311db0 0000001e 00000008
[   26.060000] 1da0: 0000001f 8e8548c4 00000000 8f311db8 0000000f 
8f2ecc40 8f311db8 8f311db8
[   26.060000] 1dc0: 88052576 8f311de4 0000001e 8f2ecc40 fffffff3 
8f2ecc80 8e8548c4 00000000
[   26.060000] 1de0: 00000000 8804d12a 8f311dec 8f311e48 8f3078a4 
8e8548c4 8e854828 8f311e08
[   26.060000] 1e00: 8805d0a0 8f311e20 8f2b6290 00000000 8f3078a4 
8f2e7bf0 00000001 8f311e48
[   26.060000] 1e20: 296fd9d8 8f261c20 00000000 00000000 00000000 
0000ffff 00000000 296fe000
[   26.060000] 1e40: 00000000 00000000 00000001 0000001e 296fc000 
00000000 8805de16 8f311e88
[   26.060000] 1e60: 8f261c20 00000000 00000000 8f2e7bf0 00000000 
00000000 0000001e 00000001
[   26.060000] 1e80: 00000000 00000000 00000001 296fd9d8 8f3078a4 
8f261c20 00000000 00000000
[   26.060000] 1ea0: 00000000 00000000 8f3078cc 00000000 00000000 
00000000 00000000 00000000
[   26.060000] 1ec0: 00000000 00000000 00000000 8f2b6290 00001bf0 
8f311ef4 88010fb0 8f311ef8
[   26.060000] 1ee0: 8f261c20 29569b88 8f3078a4 296fd9d8 00000000 
296fd9d8 00000001 8f311fa4
[   26.060000] 1f00: 8f0792c0 00000000 00000001 8e854828 00000001 
8f2af2c8 8f2af2d0 8f307954
[   26.060000] 1f20: 880630be 8f311f48 8f261c60 00000000 296fc000 
00002000 8f2ecc40 00000073
[   26.060000] 1f40: 00000073 0000001e 00000003 00000003 88171536 
8f311f58 880300c2 8f311f74
[   26.820000] 1f60: 00000012 8f2ecc40 296fc000 0000001e 000000bc 
88007d92 8f311f7c 000019d8
[   26.828000] 1f80: 296fc000 8800a0ec 7bf52d44 296b0000 29569b88 
00000003 8800a0ec 8800a0ec
[   26.836000] 1fa0: 00000001 296fc000 0000133c 296fd9d8 00000000 
00001fff 000019d8 2955e064
[   26.844000] 1fc0: 00000012 2955e05c 00001fff 2955e000 00000003 
29569b88 296b0000 7bf52d44
[   26.852000] 1fe0: 7bf52d44 29558320 295582b0 00008000 00000000 
00000000 000001e0 ffffffff
[   26.860000]
[   26.860000] Call trace:
[   26.864000]  [<8800840a>] dump_stack+0xe/0x1c
[   26.868000]  [<8801369c>] __schedule_bug+0x40/0x68
[   26.876000]  [<882b156a>] schedule+0x6a/0x42c
[   26.880000]  [<880136da>] __cond_resched+0x16/0x38
[   26.884000]  [<882b1eaa>] _cond_resched+0x22/0x38
[   26.888000]  [<8806f774>] quicklist_trim+0x0/0x118
[   26.892000]  [<8805f288>] unmap_vmas+0x4ac/0x592
[   26.896000]  [<88061522>] exit_mmap+0x86/0x16c
[   26.904000]  [<880133ec>] add_preempt_count+0x0/0x78
[   26.908000]  [<88017fd2>] mmput+0x2e/0xe0
[   26.912000]  [<8801b82e>] exit_mm+0xe2/0x120
[   26.916000]  [<8801cdbc>] do_exit+0x594/0x5f4
[   26.920000]  [<8801cdc8>] do_exit+0x5a0/0x5f4
[   26.924000]  [<8801ab04>] printk+0x0/0x30
[   26.928000]  [<88008552>] die+0x10e/0x18c
[   26.932000]  [<8801ab04>] printk+0x0/0x30
[   26.936000]  [<88011106>] do_page_fault+0x24e/0x358
[   26.940000]  [<8801ab04>] printk+0x0/0x30
[   26.944000]  [<8828f1fc>] xprt_prepare_transmit+0x50/0x94
[   26.952000]  [<8801f122>] local_bh_enable+0x42/0x94
[   26.956000]  [<8801f13a>] local_bh_enable+0x5a/0x94
[   26.960000]  [<8828f20e>] xprt_prepare_transmit+0x62/0x94
[   26.968000]  [<8828e6b2>] call_transmit+0x3a/0x1e4
[   26.972000]  [<88294096>] __rpc_execute+0x6e/0x254
[   26.976000]  [<8801f122>] local_bh_enable+0x42/0x94
[   26.980000]  [<8801f13a>] local_bh_enable+0x5a/0x94
[   26.984000]  [<882940d4>] __rpc_execute+0xac/0x254
[   26.992000]  [<882942b6>] rpc_execute+0x22/0x34
[   26.996000]  [<8828daec>] rpc_run_task+0x48/0x68
[   27.000000]  [<880ef5c2>] nfs_read_rpcsetup+0x16e/0x1c0
[   27.004000]  [<8800a0ec>] ret_from_exception+0x0/0x8
[   27.008000]  [<880ef0b4>] readpage_async_filler+0x0/0x150
[   27.016000]  [<8800a0ec>] ret_from_exception+0x0/0x8
[   27.020000]  [<8800a0ec>] ret_from_exception+0x0/0x8
[   27.024000]  [<880ef0b4>] readpage_async_filler+0x0/0x150
[   27.032000]  [<88010a30>] sh4_flush_dcache_page+0x94/0x168
[   27.036000]  [<8800fc8e>] flush_dcache_page+0x1a/0x4c
[   27.040000]  [<8801099c>] sh4_flush_dcache_page+0x0/0x168
[   27.048000]  [<880ef198>] readpage_async_filler+0xe4/0x150
[   27.052000]  [<880529a2>] read_cache_pages+0x5a/0xc0
[   27.056000]  [<880eee2a>] nfs_readpages+0xfa/0x1bc
[   27.064000]  [<880ef838>] nfs_pagein_multi+0x0/0x138
[   27.068000]  [<880524ae>] __do_page_cache_readahead+0x11e/0x1cc
[   27.072000]  [<88052576>] ra_submit+0x1a/0x28
[   27.076000]  [<8804d12a>] filemap_fault+0x19e/0x384
[   27.084000]  [<8805d0a0>] __do_fault+0x58/0x3b0
[   27.088000]  [<8805de16>] handle_mm_fault+0x362/0x78c
[   27.092000]  [<88010fb0>] do_page_fault+0xf8/0x358
[   27.096000]  [<880630be>] do_mmap_pgoff+0x2ae/0x304
[   27.104000]  [<88171536>] __up_write+0xee/0x130
[   27.108000]  [<880300c2>] up_write+0xa/0x18
[   27.112000]  [<88007d92>] old_mmap+0x82/0xb4
[   27.116000]  [<8800a0ec>] ret_from_exception+0x0/0x8
[   27.120000]  [<8800a0ec>] ret_from_exception+0x0/0x8
[   27.124000]  [<8800a0ec>] ret_from_exception+0x0/0x8
[   27.132000]
[   34.908000] nfs: server 192.168.0.103 not responding, still trying
[   43.712000] nfs: server 192.168.0.103 not responding, still trying
[   52.516000] nfs: server 192.168.0.103 not responding, still trying
[   61.320000] nfs: server 192.168.0.103 not responding, still trying
[   70.120000] nfs: server 192.168.0.103 not responding, still trying
[   78.924000] nfs: server 192.168.0.103 not responding, still trying
[   96.528000] nfs: server 192.168.0.103 not responding, still trying
[  114.132000] nfs: server 192.168.0.103 not responding, still trying
[  132.816000] NETDEV WATCHDOG: eth0 (r8169): transmit queue 0 timed out
[  132.820000] ------------[ cut here ]------------
[  132.820000] Badness at net/sched/sch_generic.c:261
[  132.820000]
[  132.820000] Pid : 0, Comm:           swapper
[  132.820000] CPU : 0                  Tainted: G      D     
(2.6.32-rc3-00376-g28ef99d-dirty #248)
[  132.820000]
[  132.820000] PC is at dev_watchdog+0xfe/0x1e8
[  132.820000] PR is at dev_watchdog+0xfe/0x1e8
[  132.820000] PC  : 8824c602 SP  : 88397e98 SR  : 40008101 TEA : 00000008
[  132.820000] R0  : 0000004f R1  : 88396000 R2  : 88396000 R3  : 88403c48
[  132.820000] R4  : 00000001 R5  : 00007051 R6  : ffffffff R7  : 000000df
[  132.820000] R8  : 00000000 R9  : 8f011000 R10 : 00000000 R11 : 00000001
[  132.820000] R12 : 00000000 R13 : 00000004 R14 : 88397e98
[  132.820000] MACH: 00000414 MACL: 00000000 GBR : 62c72820 PR  : 8824c602
[  132.820000]
[  132.820000] Call trace:
[  132.820000]  [<88030039>] hrtimer_run_pending+0x79/0xe0
[  132.820000]  [<880376cc>] tick_dev_program_event+0x38/0xc0
[  132.820000]  [<880377a4>] tick_program_event+0x14/0x24
[  132.820000]  [<88022c88>] run_timer_softirq+0x100/0x1ac
[  132.820000]  [<8824c504>] dev_watchdog+0x0/0x1e8
[  132.820000]  [<8801e9e6>] __do_softirq+0x7a/0x128
[  132.820000]  [<8801eacc>] do_softirq+0x38/0x70
[  132.820000]  [<883ca520>] __alloc_bootmem+0x0/0x18
[  132.820000]  [<8801edd2>] irq_exit+0x32/0x58
[  132.820000]  [<880058d8>] do_IRQ+0x38/0x60
[  132.820000]  [<8800a0f4>] ret_from_irq+0x0/0x10
[  132.820000]  [<880058a0>] do_IRQ+0x0/0x60
[  132.820000]  [<8800523c>] default_idle+0x0/0x78
[  132.820000]  [<883ca520>] __alloc_bootmem+0x0/0x18
[  132.820000]  [<88005268>] default_idle+0x2c/0x78
[  132.820000]  [<880051e8>] cpu_idle+0x28/0x7c
[  132.820000]  [<882a8a64>] rest_init+0x54/0x98
[  132.820000]  [<88005b9c>] kernel_thread+0x0/0x70
[  132.820000]  [<883c4928>] start_kernel+0x43c/0x470
[  132.820000]  [<8800402c>] _stext+0x2c/0x38
[  132.820000]  [<88004000>] _stext+0x0/0x38
[  132.820000]
[  133.012000] r8169: eth0: link up

The picture may variate somehow.
But it always hangs on sapwood.

How do you think if it is possible to use only one loop
and ocbwb/ocbi/ocbp with virtual address instead of associative writing 
to all ways?
Or there are some restriction on doing that ?

Best regards,
Valentin.

Paul Mundt wrote:
> On Tue, Oct 13, 2009 at 12:13:52PM +0400, Valentin R Sitsikov wrote:
>   
>> Hello Paul.
>> Thanks a lot i will try it.
>> I am a little bit confused about 4096.  Page size  is not always  equal 
>> to 4096.
>> In my particular case page size is equal to 8192.
>> How do you think if it might be a problem ?
>>
>>     
> The code itself is a bit misleading, the 4096 there does not relate to
> the page size, only that the routine in question is flushing 4k at a
> time. The way increment >> 12 gives us the number of iterations that need
> to be done to cover the way. However, you are correct that this bit of
> code is suspect, as it only implements a 1-way flush! Somewhere in all
> the noise I stupidly killed off the way loop.
>
> Your patch to switch this over to PAGE_SIZE looks fine, although
> flush_dcache_page() still needs a bit of refactoring, as the loop is no
> longer necessary.
>
> It still needs a bit of a think, but this is roughly what I'm thinking:
>
> ---
>
> diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
> index 56dd55a..7dd99d1 100644
> --- a/arch/sh/mm/cache-sh4.c
> +++ b/arch/sh/mm/cache-sh4.c
> @@ -16,6 +16,7 @@
>  #include <linux/mutex.h>
>  #include <linux/fs.h>
>  #include <linux/highmem.h>
> +#include <linux/pagemap.h>
>  #include <asm/pgtable.h>
>  #include <asm/mmu_context.h>
>  #include <asm/cacheflush.h>
> @@ -27,8 +28,11 @@
>   */
>  #define MAX_ICACHE_PAGES	32
>  
> -static void __flush_cache_4096(unsigned long addr, unsigned long phys,
> -			       unsigned long exec_offset);
> +static void __flush_cache_alias(unsigned long addr,
> +		unsigned long kaddr, struct cache_info *ci);
> +
> +static void (*__flush_cache_alias_uncached)(unsigned long addr,
> +		unsigned long kaddr, struct cache_info *ci);
>  
>  /*
>   * Write back the range of D-cache, and purge the I-cache.
> @@ -82,53 +86,6 @@ static void __uses_jump_to_uncached sh4_flush_icache_range(void *args)
>  	local_irq_restore(flags);
>  }
>  
> -static inline void flush_cache_4096(unsigned long start,
> -				    unsigned long phys)
> -{
> -	unsigned long flags, exec_offset = 0;
> -
> -	/*
> -	 * All types of SH-4 require PC to be uncached to operate on the I-cache.
> -	 * Some types of SH-4 require PC to be uncached to operate on the D-cache.
> -	 */
> -	if ((boot_cpu_data.flags & CPU_HAS_P2_FLUSH_BUG) ||
> -	    (start < CACHE_OC_ADDRESS_ARRAY))
> -		exec_offset = cached_to_uncached;
> -
> -	local_irq_save(flags);
> -	__flush_cache_4096(start | SH_CACHE_ASSOC,
> -			   virt_to_phys(phys), exec_offset);
> -	local_irq_restore(flags);
> -}
> -
> -/*
> - * Write back & invalidate the D-cache of the page.
> - * (To avoid "alias" issues)
> - */
> -static void sh4_flush_dcache_page(void *arg)
> -{
> -	struct page *page = arg;
> -#ifndef CONFIG_SMP
> -	struct address_space *mapping = page_mapping(page);
> -
> -	if (mapping && !mapping_mapped(mapping))
> -		set_bit(PG_dcache_dirty, &page->flags);
> -	else
> -#endif
> -	{
> -		unsigned long phys = page_to_phys(page);
> -		unsigned long addr = CACHE_OC_ADDRESS_ARRAY;
> -		int i, n;
> -
> -		/* Loop all the D-cache */
> -		n = boot_cpu_data.dcache.way_incr >> 12;
> -		for (i = 0; i < n; i++, addr += 4096)
> -			flush_cache_4096(addr, phys);
> -	}
> -
> -	wmb();
> -}
> -
>  /* TODO: Selective icache invalidation through IC address array.. */
>  static void __uses_jump_to_uncached flush_icache_all(void)
>  {
> @@ -180,6 +137,63 @@ static void sh4_flush_cache_all(void *unused)
>  	flush_icache_all();
>  }
>  
> +static inline void flush_cache_alias(unsigned long start, unsigned long kaddr)
> +{
> +	void (*__flush_cache_alias_wrapper)(unsigned long addr,
> +			unsigned long kaddr, struct cache_info *ci);
> +	struct cache_info *ci;
> +	unsigned long flags;
> +
> +	/*
> +	 * All types of SH-4 require PC to be uncached to operate on the I-cache.
> +	 * Some types of SH-4 require PC to be uncached to operate on the D-cache.
> +	 */
> +	if (start < CACHE_OC_ADDRESS_ARRAY) {
> +		ci = &boot_cpu_data.icache;
> +		__flush_cache_alias_wrapper = __flush_cache_alias_uncached;
> +	} else {
> +		ci = &boot_cpu_data.dcache;
> +		if (boot_cpu_data.flags & CPU_HAS_P2_FLUSH_BUG)
> +			__flush_cache_alias_wrapper > +				__flush_cache_alias_uncached;
> +		else
> +			__flush_cache_alias_wrapper = __flush_cache_alias;
> +	}
> +
> +	local_irq_save(flags);
> +	__flush_cache_alias_wrapper(start | SH_CACHE_ASSOC, kaddr, ci);
> +	local_irq_restore(flags);
> +}
> +
> +/*
> + * Write back & invalidate the D-cache of the page.
> + * (To avoid "alias" issues)
> + */
> +static void sh4_flush_dcache_page(void *arg)
> +{
> +	struct page *page = arg;
> +	struct address_space *mapping = page_mapping(page);
> +
> +#ifndef CONFIG_SMP
> +	if (mapping && !mapping_mapped(mapping))
> +		set_bit(PG_dcache_dirty, &page->flags);
> +	else
> +#endif
> +	{
> +		unsigned long phys = page_to_phys(page);
> +		unsigned long pgoff = page->index << PAGE_CACHE_SHIFT;
> +
> +		flush_cache_alias(CACHE_OC_ADDRESS_ARRAY |
> +				  (unsigned long)page_address(page), phys);
> +
> +		if (mapping) {
> +			flush_cache_alias(CACHE_OC_ADDRESS_ARRAY |
> +					  (pgoff & shm_align_mask), phys);
> +			flush_icache_all();
> +		}
> +	}
> +}
> +
>  /*
>   * Note : (RPC) since the caches are physically tagged, the only point
>   * of flush_cache_mm for SH-4 is to get rid of aliases from the
> @@ -257,7 +271,7 @@ static void sh4_flush_cache_page(void *args)
>  	}
>  
>  	if (pages_do_alias(address, phys))
> -		flush_cache_4096(CACHE_OC_ADDRESS_ARRAY |
> +		flush_cache_alias(CACHE_OC_ADDRESS_ARRAY |
>  			(address & shm_align_mask), phys);
>  
>  	if (vma->vm_flags & VM_EXEC)
> @@ -306,60 +320,26 @@ static void sh4_flush_cache_range(void *args)
>  		flush_icache_all();
>  }
>  
> -/**
> - * __flush_cache_4096
> - *
> - * @addr:  address in memory mapped cache array
> - * @phys:  P1 address to flush (has to match tags if addr has 'A' bit
> - *         set i.e. associative write)
> - * @exec_offset: set to 0x20000000 if flush has to be executed from P2
> - *               region else 0x0
> - *
> - * The offset into the cache array implied by 'addr' selects the
> - * 'colour' of the virtual address range that will be flushed.  The
> - * operation (purge/write-back) is selected by the lower 2 bits of
> - * 'phys'.
> - */
> -static void __flush_cache_4096(unsigned long addr, unsigned long phys,
> -			       unsigned long exec_offset)
> +static void __uses_jump_to_uncached
> +__flush_cache_alias(unsigned long addr, unsigned long kaddr, struct cache_info *ci)
>  {
>  	int way_count;
>  	unsigned long base_addr = addr;
> -	struct cache_info *dcache;
>  	unsigned long way_incr;
>  	unsigned long a, ea, p;
> -	unsigned long temp_pc;
>  
> -	dcache = &boot_cpu_data.dcache;
>  	/* Write this way for better assembly. */
> -	way_count = dcache->ways;
> -	way_incr = dcache->way_incr;
> -
> -	/*
> -	 * Apply exec_offset (i.e. branch to P2 if required.).
> -	 *
> -	 * FIXME:
> -	 *
> -	 *	If I write "=r" for the (temp_pc), it puts this in r6 hence
> -	 *	trashing exec_offset before it's been added on - why?  Hence
> -	 *	"=&r" as a 'workaround'
> -	 */
> -	asm volatile("mov.l 1f, %0\n\t"
> -		     "add   %1, %0\n\t"
> -		     "jmp   @%0\n\t"
> -		     "nop\n\t"
> -		     ".balign 4\n\t"
> -		     "1:  .long 2f\n\t"
> -		     "2:\n" : "=&r" (temp_pc) : "r" (exec_offset));
> +	way_count = ci->ways;
> +	way_incr = ci->way_incr;
>  
>  	/*
>  	 * We know there will be >=1 iteration, so write as do-while to avoid
>  	 * pointless nead-of-loop check for 0 iterations.
>  	 */
>  	do {
> -		ea = base_addr + 4096;
> +		ea = base_addr + PAGE_SIZE;
>  		a = base_addr;
> -		p = phys;
> +		p = kaddr;
>  
>  		do {
>  			*(volatile unsigned long *)a = p;
> @@ -389,6 +369,13 @@ void __init sh4_cache_init(void)
>  		ctrl_inl(CCN_CVR),
>  		ctrl_inl(CCN_PRR));
>  
> +	/*
> +	 * Pre-calculate the uncached version so it can be called
> +	 * directly.
> +	 */
> +	__flush_cache_alias_uncached = &__flush_cache_alias +
> +				       cached_to_uncached;
> +
>  	local_flush_icache_range	= sh4_flush_icache_range;
>  	local_flush_dcache_page		= sh4_flush_dcache_page;
>  	local_flush_cache_all		= sh4_flush_cache_all;
>   

