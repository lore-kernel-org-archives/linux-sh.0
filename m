From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 20 Nov 2019 04:27:44 +0000
Subject: Re: [PATCH] arch/sh/: fix NUMA build errors
Message-Id: <802dc73e-080d-05aa-76fe-165bb4817959@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
 <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
In-Reply-To: <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 11/18/19 11:38 PM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Tue, Nov 19, 2019 at 1:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Fix SUPERH builds that select SYS_SUPPORTS_NUMA but do not select
>> SYS_SUPPORTS_SMP and SMP.
>>
>> kernel/sched/topology.c is only built for CONFIG_SMP and then the NUMA
>> code + data inside topology.c is only built when CONFIG_NUMA is
>> set/enabled, so these arch/sh/ configs need to select SMP and
>> SYS_SUPPORTS_SMP to build the NUMA support.
>>
>> Fixes this build error in 3 different SUPERH configs:
>>
>> mm/page_alloc.o: In function `get_page_from_freelist':
>> page_alloc.c:(.text+0x2ca8): undefined reference to `node_reclaim_distance'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: linux-sh@vger.kernel.org
>> ---
>> or maybe these should be fixed in the defconfig files?
>>
>> or alternatively, does it make any sense to support NUMA without SMP?
> 
> I think it does.  From arch/sh/mm/Kconfig config NUMA help:
> 
>         Some SH systems have many various memories scattered around
>         the address space, each with varying latencies. This enables
>         support for these blocks by binding them to nodes and allowing
>         memory policies to be used for prioritizing and controlling
>         allocation behaviour.

Note that this help text is under:
config NUMA
	bool "Non-Uniform Memory Access (NUMA) Support"
	depends on MMU && SYS_SUPPORTS_NUMA
	select ARCH_WANT_NUMA_VARIABLE_LOCALITY

but ARCH_WANT_NUMA_VARIABLE_LOCALITY seems to be unimplemented anywhere in
the kernel source tree.  I.e., the Kconfig symbol exists in init/Kconfig,
but there is no code to support its use.


> Probably the NUMA-core is too server/x86-centric, by assuming NUMA is
> used only on systems with multiple CPUs, each with their own RAM.
> 
> AFAIK, none of the SoCs below are SMP:
> 
>> --- lnx-54-rc8.orig/arch/sh/Kconfig
>> +++ lnx-54-rc8/arch/sh/Kconfig
>> @@ -508,6 +508,8 @@ config CPU_SUBTYPE_SH7722
>>         select CPU_SHX2
>>         select ARCH_SHMOBILE
>>         select ARCH_SPARSEMEM_ENABLE
>> +       select SYS_SUPPORTS_SMP
>> +       select SMP
>>         select SYS_SUPPORTS_NUMA
>>         select SYS_SUPPORTS_SH_CMT
>>         select PINCTRL
>> @@ -518,6 +520,8 @@ config CPU_SUBTYPE_SH7366
>>         select CPU_SHX2
>>         select ARCH_SHMOBILE
>>         select ARCH_SPARSEMEM_ENABLE
>> +       select SYS_SUPPORTS_SMP
>> +       select SMP
>>         select SYS_SUPPORTS_NUMA
>>         select SYS_SUPPORTS_SH_CMT
> 
> BTW, you didn't have the issue with CPU_SHX3 and CPU_SUBTYPE_SH7785?
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


-- 
~Randy
