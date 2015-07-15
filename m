From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Jul 2015 05:56:33 +0000
Subject: Re: [PATCH v3 00/04] ARM: shmobile: r8a7779 Marzen multiplatform cleanup V3
Message-Id: <CANqRtoQFjuDuNu0J_FdJC3VTYwUDw8YH5owoZ7u2q65zLaHqew@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150713061450.25534.96315.sendpatchset@little-apple>
In-Reply-To: <20150713061450.25534.96315.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Jul 15, 2015 at 10:16 AM, Simon Horman <horms@verge.net.au> wrote:
> Hi Magnus,
>
> On Wed, Jul 15, 2015 at 09:25:01AM +0900, Simon Horman wrote:
>> Hi Magnus,
>>
>> On Mon, Jul 13, 2015 at 03:14:50PM +0900, Magnus Damm wrote:
>> > ARM: shmobile: r8a7779 Marzen multiplatform cleanup V3
>> >
>> > [PATCH v3 01/04] ARM: shmobile: r8a7779: Generic SMP ops
>> > [PATCH v3 02/04] ARM: shmobile: marzen-reference: Remove C board code
>> > [PATCH v3 03/04] ARM: shmobile: Remove Marzen from shmobile_defconfig
>> > [PATCH v3 04/04] ARM: shmobile: r8a7779: Cleanup header file
>> >
>> > This series is simply resending the remaining r8a7779 multiplatform
>> > cleanup patches. The code has not changed since V2:
>> >
>> > [PATCH v2 00/06] ARM: shmobile: r8a7779 IRQ update and Marzen cleanup V2
>> >
>> > With these patches applied the r8a7779 SoC gets DT-only multiplatform
>> > support and old C board code for multiplatform gets removed.
>> >
>> > The legacy r8a7779 Marzen code is not touched by this series, but
>> > with these patches applied basic r8a7779 multiplatform SoC support
>> > is done and only a few I/O devices are legacy-only.
>>
>> Thanks, I have queued these up.
>>
>> Please send a follow-up patch to address Geert's observation that
>> CONFIG_MACH_MARZEN should be removed from multi_v7_defconfig.
>
> Unfortunately I have noticed a problem with patch 02/04,
> and in particular the following portion of it:
>
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -89,13 +89,6 @@ config ARCH_SH73A0
>         select ARCH_RMOBILE
>         select RENESAS_INTC_IRQPIN
>
> -comment "Renesas ARM SoCs Board Type"
> -
> -config MACH_MARZEN
> -       bool "MARZEN board"
> -       depends on ARCH_R8A7779
> -       select REGULATOR_FIXED_VOLTAGE if REGULATOR
> -
>
> It appears that with the above applied REGULATOR_FIXED_VOLTAGE is
> no longer set after make shmobile_defconfig which causes all sorts of
> trouble as the fixed regulator is used by many devices on many boards.

Right, the regulator portion is indeed troublesome. And like you say,
it is needed for many boards including Gen2.

> I wonder if the best way forwards would be to simply enable
> REGULATOR_FIXED_VOLTAGE in shmobile_defconfig (and probably
> multi_v7_defconfig too).

Yeah, I think so.

Thanks,

/ magnus
