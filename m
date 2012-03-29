From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Mar 2012 04:48:19 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 generic board support via DT V2
Message-Id: <CANqRtoRbutFeqH5baBfQ7fF+3p=vY09xeCUZEBnRcNtbeYBQcA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110707134813.22370.25948.sendpatchset@t400s>
In-Reply-To: <20110707134813.22370.25948.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hello Rafael,

2012/3/29 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> On Wednesday, March 28, 2012, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add generic DT board support for the sh7372 SoC V2.
>>
>> SCIF serial ports and timers are kept as regular
>> platform devices. Other on-chip and on-board devices
>> should be configured via the device tree.
>>
>> Tested on the mackerel board via kexec using a zImage
>> kernel with an appended dtb.
>>
>> At this point there is no interrupt controller support
>> in place but such code will be added over time when
>> proper IRQ domain support has been added to INTC.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> My understanding is that this patch along with the
> "[PATCH 00/06] mach-shmobile device tree preparation patches V2" series is
> sufficient for preliminary support of device trees on sh7372. =A0For this
> reason, I have put those patches into the dt branch at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git

Great, thanks for your help!

> However, the branch is based on v3.3 final, so I've had to rebase two pat=
ches
> on top of it. =A0Magnus, can you please double check if the commits look =
good?

Sorry, it does not seem ok. This patch and the earlier series "[PATCH
00/06] mach-shmobile device tree preparation patches V2" were built on
top of the renesas git tree commit
a6e24019468009a21b674e392d74283a90f415dd (origin/master at the
moment). Using v3.3 final will not work due to missing patches.

The following log shows the first 3 commits in origin/master and
origin/dt for arch/arm/mach-shmobile/setup-sh7372.c:

damm@w520 ~/git/renesas $ git log --oneline origin/master
arch/arm/mach-shmobile/setup-sh7372.c | head -n 3
17254bf ARM: mach-shmobile: sh7372, AP4EVB and Mackerel timer rework
5d7220ec ARM: mach-shmobile: sh7372 map_io and init_early update
c8ddf03 ARM: mach-shmobile: both USB DMAC instances on sh7372 are slave-only
damm@w520 ~/git/renesas $ git log --oneline origin/dt
arch/arm/mach-shmobile/setup-sh7372.c | head -n 3
71f5ef5 ARM: mach-shmobile: sh7372 generic board support via DT V2
c8ddf03 ARM: mach-shmobile: both USB DMAC instances on sh7372 are slave-only
57f2685 Merge branch 'next' of git://git.infradead.org/users/vkoul/slave-dma
damm@w520 ~/git/renesas $

The patches "ARM: mach-shmobile: sh7372, AP4EVB and Mackerel timer
rework" and "ARM: mach-shmobile: sh7372 map_io and init_early update"
and all their dependencies are needed, so please base on your current
origin/master to avoid the following errors:

arch/arm/mach-shmobile/setup-sh7372.c: In function
'sh7372_add_early_devices_dt':
arch/arm/mach-shmobile/setup-sh7372.c:1059:2: error: implicit
declaration of function 'shmobile_setup_delay'
arch/arm/mach-shmobile/setup-sh7372.c:1065:2: error: implicit
declaration of function 'shmobile_setup_console'
arch/arm/mach-shmobile/setup-sh7372.c: In function
'sh7372_add_standard_devices_dt':
arch/arm/mach-shmobile/setup-sh7372.c:1075:2: error: implicit
declaration of function 'sh7372_clock_init'
arch/arm/mach-shmobile/setup-sh7372.c: At top level:
arch/arm/mach-shmobile/setup-sh7372.c:1090:12: error: 'sh7372_map_io'
undeclared here (not in a function)
arch/arm/mach-shmobile/setup-sh7372.c:1093:14: error:
'sh7372_init_irq' undeclared here (not in a function)
arch/arm/mach-shmobile/setup-sh7372.c:1094:16: error:
'shmobile_handle_irq_intc' undeclared here (not in a function)
arch/arm/mach-shmobile/setup-sh7372.c:1096:12: error: 'shmobile_timer'
undeclared here (not in a function)
make[1]: *** [arch/arm/mach-shmobile/setup-sh7372.o] Error 1
make: *** [arch/arm/mach-shmobile] Error 2

Thanks,

/ magnus
