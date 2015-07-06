From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 06 Jul 2015 07:58:12 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779 Marzen legacy fix
Message-Id: <CANqRtoTi1ngiQCSvcrdhkNTxgvKLD2RgRYLUz-EnOg=kRyGOyA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150706070216.25453.35953.sendpatchset@little-apple>
In-Reply-To: <20150706070216.25453.35953.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Jul 6, 2015 at 4:53 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Monday 06 July 2015 16:02:16 Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Unbreak the r8a7779 Marzen legacy code provided by marzen_defconfig.
>>
>> As it is today Marzen multiplatform is working, but the legacy code
>> is broken. This patch intends to leave multiplatform as-is but do
>> a simple one-shot fix to unbreak the legacy code base.
>>
>> Without this patch there is no preset delay and the TWD is defined
>> both in C code and in DT. Solve the delay by invoking shmobile_init_delay()
>> and simply exclude the TWD DT instance in case of building for legacy.
>>
>> Marzen legacy code will be removed in the near future, but until then
>> we may as well avoid breaking it.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  Built on top of renesas-devel-20150629-v4.1
>>
>>  arch/arm/boot/dts/r8a7779.dtsi         |    4 ++--
>>  arch/arm/mach-shmobile/setup-r8a7779.c |    2 ++
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> --- 0001/arch/arm/boot/dts/r8a7779.dtsi
>> +++ work/arch/arm/boot/dts/r8a7779.dtsi       2015-07-06 15:42:28.182366518 +0900
>> @@ -62,7 +62,7 @@
>>               reg = <0xf0001000 0x1000>,
>>                     <0xf0000100 0x100>;
>>       };
>> -
>> +#ifndef CONFIG_ARCH_SHMOBILE_LEGACY /* TWD defined in C code for legacy
>> case */ timer@f0000600 {
>>               compatible = "arm,cortex-a9-twd-timer";
>>               reg = <0xf0000600 0x20>;
>> @@ -70,7 +70,7 @@
>>                       (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>>               clocks = <&cpg_clocks R8A7779_CLK_ZS>;
>>       };
>> -
>> +#endif
>
> DT should really not depend on kernel configuration. Can't you disable the
> device from legacy board/SoC code instead ?

I agree about that dependency issue, and it may be quite possible to
do something at runtime.

At this time I feel it becomes slightly more advanced than I initially
had hoped for. I would of course prefer to remove the legacy rather
soon, and once we do that we can simply get rid of that ugly ifdef.

Anyway, I'll have a look at this tomorrow.

Thanks,

/ magnus
