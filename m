From: Mike Travis <travis@sgi.com>
Date: Thu, 08 May 2008 21:55:08 +0000
Subject: Re: sh migor_defconfig build breakage
Message-Id: <482376BC.2000404@sgi.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080508203949.GC22887@cs181133002.pp.htv.fi> <48236E59.8070400@sgi.com> <4823711D.70401@sgi.com>
In-Reply-To: <4823711D.70401@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Mike Travis wrote:
> Mike Travis wrote:
>> Adrian Bunk wrote:
>>> Commit aa6b54461cc5c0019b9d792adf3176b444c10763
>>> (asm-generic: add node_to_cpumask_ptr macro)
>>> causes the following build error with migor_defconfig:
>>>
>>> <--  snip  -->
>>>
>>> ...
>>>   CC      arch/sh/kernel/asm-offsets.s
>>> In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/mm.h:8,
>>>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/kernel/asm-offsets.c:13:
>>> /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/gfp.h: In function 'alloc_pages_node':
>>> /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/gfp.h:190: 
>>> error: implicit declaration of function 'cpu_to_node'
>>> make[2]: *** [arch/sh/kernel/asm-offsets.s] Error 1
>>>
>>> <--  snip  -->
>>>
>>> cu
>>> Adrian
...
> Ouch.  I just discovered I don't have a cross-compiler for 'sh'.  Can you point me
> towards one?
...

It looks like the migor_config has NUMA=y so is there not a cpu_to_node function?
(looking with cscope didn't find it.)

I believe this may be the source of the error:

include/linux/gfp.h:

static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
                                                unsigned int order)
{
...
        /* Unknown node is current node */
        if (nid < 0)
                nid = numa_node_id();


include/linux/mmzone.h:

#include <linux/topology.h>
/* Returns the number of the current Node. */
#ifndef numa_node_id
#define numa_node_id()          (cpu_to_node(raw_smp_processor_id()))
#endif


I can't put into include/linux/topology.h the catchall default:

#ifndef cpu_to_node
#define cpu_to_node(cpu)	(0)
#endif

Because some arch's have it defined as an inline function.  Perhaps the
easiest would be to add to include/asm-sh/topology.h a simple define of
cpu_to_node()?

Thanks,
Mike
