From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 09 Apr 2014 23:57:20 +0000
Subject: Re: [PATCH 00/02] ARM: shmobile: r8a7790 8-core boot prototype
Message-Id: <CANqRtoTdwXGqHqssTiMyztrxH6suLF9DiwmFt13THnSXCif-tg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140408124758.9773.14458.sendpatchset@w520>
In-Reply-To: <20140408124758.9773.14458.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Apr 9, 2014 at 2:05 PM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Apr 09, 2014 at 01:11:43PM +0900, Magnus Damm wrote:
>> Hi Simon,
>>
>> On Wed, Apr 9, 2014 at 9:24 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Tue, Apr 08, 2014 at 09:47:58PM +0900, Magnus Damm wrote:
>> >> ARM: shmobile: r8a7790 8-core boot prototype
>> >>
>> >> [PATCH 01/02] ARM: shmobile: Multicluster APMU prototype support
>> >> [PATCH 02/02] ARM: shmobile: r8a7790 CCI configuration
>> >>
>> >> Prototype patches to allow 8-core boot on r8a7790. The first patch
>> >> unlocks multicluster support to allo SMP boot of all CPU cores, and
>> >> the second initializes the CCI-400 hardware.
>> >
>> > Hi Magnus,
>> >
>> > I applied these patches on top of renesas-devel-v3.14-20140408,
>> > compiled using the shmobile_defconfig, and booted a Lager board.
>> > I was expecting to see 8 cores in /proc/cpuinfo but I only see 4.
>> >
>> > Are my expectations wrong or am I missing something?
>>
>> The maximum number of CPUs in the kernel config may be limited to 4 by default?
>
> The shmobile_defconfig yeilds CONFIG_NR_CPUS=8, which seems fine.
>
>> Also, to use CA7 with upstream you need to disable the arch timer and
>> rely on CMT.
>
> Thanks I have disabled CONFIG_HAVE_ARM_ARCH_TIMER.
>
>> To clarify, I don't expect these to be merged upstream. Also, I don't
>> believe the standard kernel config needs to work out of the box.
>
> That is fine. But even with the above tweak I still don't see 8 CPUs
> so I do wonder what the trick to seeing them is.
>
> ...
> CPU: Testing write buffer coherency: ok
> CPU0: update cpu_power 1535
> CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> Setting up static identity map for 0x404141b8 - 0x40414210
> CPU1: Booted secondary processor
> CPU1: update cpu_power 1535
> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> CPU2: Booted secondary processor
> CPU2: update cpu_power 1535
> CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> CPU3: Booted secondary processor
> CPU3: update cpu_power 1535
> CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> CPU4: failed to boot: -22
> CPU5: failed to boot: -22
> CPU6: failed to boot: -22
> CPU7: failed to boot: -22
> Brought up 4 CPUs
> SMP: Total of 4 processors activated.
> CPU: All CPU(s) started in SVC mode.
> ...


Thanks for providing more information. I wonder, perhaps I forgot to
tell you to also pass "apmu=multicluster" on the kernel command line
to enable all cpus?

The unlocking of multiplatform support is implemented in:
[PATCH 01/02] ARM: shmobile: Multicluster APMU prototype support

Cheers,

/ magnus
