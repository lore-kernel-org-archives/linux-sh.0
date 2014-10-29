From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Oct 2014 09:13:24 +0000
Subject: Re: [PATCH 03/03] ARM: shmobile: mackerel: Remove legacy board support
Message-Id: <CANqRtoSaCTzYGgRoJV7hcZp8RA9sL82fM+R1h9EDgsEgRs3_Wg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141029074717.405.8623.sendpatchset@w520>
In-Reply-To: <20141029074717.405.8623.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wed, Oct 29, 2014 at 5:59 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Wed, Oct 29, 2014 at 8:47 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> Remove old sh7372 Mackerel board support. The sh7372
>> SoC never went to mass production anyway and the few
>> Mackerel boards that still exist do not support DT due
>> to lack of DT bindings for the interrupt controller.
>
> This leaves a bit of fall-out:
>
> $ git grep -i mackerel
> Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt:This code has been
> tested on an mackerel board using the developer 1A eSD
> Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt:the notes in
> arch/arm/mach-shmobile/board-mackerel.c.
> Documentation/devicetree/bindings/arm/shmobile.txt:  - Mackerel
> (R0P7372LC0016RL, AP4 EVM 2nd)
> Documentation/devicetree/bindings/arm/shmobile.txt:    compatible > "renesas,mackerel"
> MAINTAINERS:F:  arch/arm/configs/mackerel_defconfig
> arch/arm/boot/dts/Makefile:     sh7372-mackerel.dtb \
> arch/arm/boot/dts/sh7372-mackerel.dts: * Device Tree Source for the
> mackerel board
> arch/arm/boot/dts/sh7372-mackerel.dts:  model = "Mackerel (AP4 EVM 2nd)";
> arch/arm/boot/dts/sh7372-mackerel.dts:  compatible = "renesas,mackerel";
> arch/arm/configs/mackerel_defconfig:CONFIG_LOCALVERSION="-mackerel"
> arch/arm/configs/mackerel_defconfig:CONFIG_MACH_MACKEREL=y
> arch/arm/tools/mach-types:mackerel              MACH_MACKEREL
>  MACKEREL                3211
> $
>
> You may want to keep zboot-rom-sdhi.txt (does this apply to any other boards?)
> and mach-types for historical reasons.

Thanks, yes, more stuff indeed needs to be removed. Regarding the
zboot bit, I think keeping that around for some time makes sense.
Perhaps trimming away the mackerel references would help. I do think
we can ditch the bindings since we phase out the board support, but
perhaps that's wrong. =)

Do you think it is good timing to get rid of Mackerel now, or do you
prefer to wait?

Cheers,

/ magnus
