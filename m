From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 06 Jul 2015 11:08:00 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779 Marzen legacy fix
Message-Id: <CANqRtoQo53JZ3aeprhT5RfXmq1bAdE6vcRX5v813ZvtK00mrYQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150706070216.25453.35953.sendpatchset@little-apple>
In-Reply-To: <20150706070216.25453.35953.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent and Geert,

On Mon, Jul 6, 2015 at 5:23 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Geert,
>
> On Monday 06 July 2015 10:07:35 Geert Uytterhoeven wrote:
>> On Mon, Jul 6, 2015 at 9:53 AM, Laurent Pinchart wrote:
>> > On Monday 06 July 2015 16:02:16 Magnus Damm wrote:
>> >> From: Magnus Damm <damm+renesas@opensource.se>
>> >>
>> >> Unbreak the r8a7779 Marzen legacy code provided by marzen_defconfig.
>> >>
>> >> As it is today Marzen multiplatform is working, but the legacy code
>> >> is broken. This patch intends to leave multiplatform as-is but do
>> >> a simple one-shot fix to unbreak the legacy code base.
>> >>
>> >> Without this patch there is no preset delay and the TWD is defined
>> >> both in C code and in DT. Solve the delay by invoking
>> >> shmobile_init_delay()
>> >> and simply exclude the TWD DT instance in case of building for legacy.
>> >>
>> >> Marzen legacy code will be removed in the near future, but until then
>> >> we may as well avoid breaking it.
>> >>
>> >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> >> ---
>> >>
>> >>  Built on top of renesas-devel-20150629-v4.1
>> >>
>> >>  arch/arm/boot/dts/r8a7779.dtsi         |    4 ++--
>> >>  arch/arm/mach-shmobile/setup-r8a7779.c |    2 ++
>> >>  2 files changed, 4 insertions(+), 2 deletions(-)
>> >>
>> >> --- 0001/arch/arm/boot/dts/r8a7779.dtsi
>> >> +++ work/arch/arm/boot/dts/r8a7779.dtsi       2015-07-06
>> >> 15:42:28.182366518 +0900 @@ -62,7 +62,7 @@
>> >>               reg = <0xf0001000 0x1000>,
>> >>                     <0xf0000100 0x100>;
>> >>       };
>> >> -
>> >> +#ifndef CONFIG_ARCH_SHMOBILE_LEGACY /* TWD defined in C code for legacy
>> >> case */
>> >>       timer@f0000600 {
>> >>               compatible = "arm,cortex-a9-twd-timer";
>> >>               reg = <0xf0000600 0x20>;
>> >> @@ -70,7 +70,7 @@
>> >>                       (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> >>               clocks = <&cpg_clocks R8A7779_CLK_ZS>;
>> >>       };
>> >> -
>> >> +#endif
>>
>> I was wondering how we did it for sh73a0/kzm9g, as I remember the TWD in
>> DT was incompatible with kzm9g-reference, but it didn't cause problems on
>> kzm9g-legacy.
>>
>> Turned out we still had separate DTSes for -legacy and -reference at that
>> time, cfr.
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/324219.h
>> tml

Right, the r8a7779 TWD DT bits were basically merged prematurely and
we did not keep track of the dependencies. It seems that only bits and
pieces get merged now and then, and in such case no one seems to keep
track of the order.

>> > DT should really not depend on kernel configuration. Can't you disable the
>> > device from legacy board/SoC code instead ?
>>
>> You mean setting its status to "disabled", before CLOCKSOURCE_OF_DECLARE()
>> is processed, i.e. before clocksource_of_init()?
>
> Something like that yes. I haven't checked what exactly is possible, but I'd
> prefer adding hacks to legacy C code that will soon be removed than to DT
> filed that we will keep.

I agree with Laurent that adding some code to the legacy bits to fix
them is much better than polluting code that will stay around. I
recall parsing DT device data in the board staging at some point, and
it may possible to simply disable DT devices at run time.

>> However, I believe clocksource_of_init() isn't called by
>> arch/arm/kernel/time.c:time_init() on marzen-legacy, as board-marzen.c
>> populates .init_time(), and board-marzen.c doesn't call it itself.

I need to look into detail about this, but if board-marzen.c never
calls clocksource_of_init() then it may be because we historically did
not use to need to call clocksource_of_init() to get the TWD going. I
think only the DT case requires that bit, but I'm not sure.

>> board-marzen-reference.c does call clocksource_of_init() from it's
>> .init_time() callback.

Right, that' inline with what we do (or at least should do) for all
multiplatform SoCs.

>> Hence am I missing something, or is marzen-legacy fine, and is only
>> marzen-reference (which is "legacy" in some sense, too) broken?
>> But you mentioned marzen_defconfig, which is for marzen-legacy?
>
> I'll let Magnus comment on that.

For this patch I target marzen_defconfig that is tied together with
board-marzen.c.

What I can tell r8a7779 multiplatform (including
board-marzen-reference.c) is fine. To avoid this kind of headache it
would have been nice to merge the TWD DT bits after removing the
legacy code.

Cheers,

/ magnus
