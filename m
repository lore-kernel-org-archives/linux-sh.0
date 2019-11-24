From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 24 Nov 2019 16:24:58 +0000
Subject: Re: [PATCH] arch/sh/: fix NUMA build errors
Message-Id: <d6eac4c0-a44b-6209-42a7-8eb535e6f437@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
 <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
 <f45f983d-8ff1-a800-2706-d71413ae1824@infradead.org>
In-Reply-To: <f45f983d-8ff1-a800-2706-d71413ae1824@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 11/19/19 1:12 PM, Randy Dunlap wrote:
> On 11/18/19 11:38 PM, Geert Uytterhoeven wrote:
>> Hi Randy,
>>
>> On Tue, Nov 19, 2019 at 1:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>> Fix SUPERH builds that select SYS_SUPPORTS_NUMA but do not select
>>> SYS_SUPPORTS_SMP and SMP.
>>>
>>> kernel/sched/topology.c is only built for CONFIG_SMP and then the NUMA
>>> code + data inside topology.c is only built when CONFIG_NUMA is
>>> set/enabled, so these arch/sh/ configs need to select SMP and
>>> SYS_SUPPORTS_SMP to build the NUMA support.
>>>
>>> Fixes this build error in 3 different SUPERH configs:
>>>
>>> mm/page_alloc.o: In function `get_page_from_freelist':
>>> page_alloc.c:(.text+0x2ca8): undefined reference to `node_reclaim_distance'
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>> Cc: Rich Felker <dalias@libc.org>
>>> Cc: linux-sh@vger.kernel.org
>>> ---
>>> or maybe these should be fixed in the defconfig files?
>>>
>>> or alternatively, does it make any sense to support NUMA without SMP?
>>
>> I think it does.  From arch/sh/mm/Kconfig config NUMA help:
>>
>>         Some SH systems have many various memories scattered around
>>         the address space, each with varying latencies. This enables
>>         support for these blocks by binding them to nodes and allowing
>>         memory policies to be used for prioritizing and controlling
>>         allocation behaviour.
> 
> Yes, I saw that and suspected it also.
> 
> I was (and still am) hoping that a SuperH maintainer comments on
> this and on how they are currently building kernels for these
> failing configs.  Maybe they have some patches that aren't in-tree yet?
> 

Yoshinori-san,
Can you share with us how you build kernels for SUPERH configs that set
CONFIG_NUMA but do not set CONFIG_SMP?  Do you have any patches for this?


> 
>> Probably the NUMA-core is too server/x86-centric, by assuming NUMA is
>> used only on systems with multiple CPUs, each with their own RAM.

Yes, I looked at all of that code for a couple of days and got nowhere
with trying to separate NUMA from SMP.

thanks.
-- 
~Randy
