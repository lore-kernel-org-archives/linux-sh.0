From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Jul 2015 06:56:20 +0000
Subject: Re: [PATCH] ARM: shmobile: rcar-gen2: CONFIG_ARM_ARCH_TIMER is always set
Message-Id: <CAMuHMdUzJPdZsGxgWs5nBPk1-O_FF58zFxPDO6jQoVH5ZnDPnQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436277927-20159-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436277927-20159-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon, Magnus,

On Wed, Jul 8, 2015 at 4:05 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jul 08, 2015 at 10:40:18AM +0900, Magnus Damm wrote:
>> On Wed, Jul 8, 2015 at 10:16 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Wed, Jul 08, 2015 at 12:34:47AM +0900, Magnus Damm wrote:
>> >> On Wed, Jul 8, 2015 at 12:21 AM, Geert Uytterhoeven
>> >> <geert@linux-m68k.org> wrote:
>> >> > HAVE_ARM_ARCH_TIMER used to be user-selectable, but your patch
>> >> > "ARM: shmobile: Select HAVE_ARM_ARCH_TIMER from Kconfig" made that
>> >> > unconditional for R-Car Gen2 and APE6 ;-)
>> >>
>> >> Ouch - my bad! That's not at all what I intended to do.
>> >>
>> >> I only wanted to express that R-Car Gen2 and APE6 come with arch timer
>> >> hardware, and in such case the user shall be able to select it. If
>> >> R-Car Gen2 or APE6 isn't selected then there is no point in exposing
>> >> such choice to the user. But obviously that wasn't what I ended up
>> >> doing...
>> >>
>> >> What would be a sane way to approach this? I think always enabling it
>> >> may not work for CA7-based SoCs from Renesas that at least used to
>> >> have setup issues with arch timer...
>> >
>> > Given the current arrangement in arch/arm/Kconfig:
>> >
>> > config HAVE_ARM_ARCH_TIMER
>> >         bool "Architected timer support"
>> >         depends on CPU_V7
>> >         select ARM_ARCH_TIMER
>> >         select GENERIC_CLOCKEVENTS
>> >         help
>> >           This option enables support for the ARM architected timer
>> >
>> > It seems to me that a good solution would be to (go back to?)
>> > * not selecting HAVE_ARM_ARCH_TIMER in arch/arm/mach-shmobile/Kconfig and;
>> > * enabling HAVE_ARM_ARCH_TIMER in defconfigs as appropriate
>>
>> That is one idea for sure.
>>
>> > Perhaps that can be achieved by dropping/reverting
>> > * 731bde02f622 ARM: shmobile: Select HAVE_ARM_ARCH_TIMER from Kconfig
>> > * b46ddcdf484c ARM: shmobile: Drop HAVE_ARM_ARCH_TIMER from defconfig
>> >
>> > At this stage I have not sent pull-requests for the above so I would
>> > be feasible for me to simply drop them if we agree on that.
>>
>> >From my side simply dropping seems the easiest way forward.
>
> Me too.
> Lets sit on this for a day or so and see what Geert and others have to say.

Typically the "HAVE_*" config symbols are meant to be selected in
Kconfig fragments, not to be configurable by the user, so Magnus' patches
did make sense to me.

ARM_ARCH_TIMER is the corresponding user-configurable config option,
but it is auto-selected by HAVE_ARM_ARCH_TIMER these days.

$ git kgrep HAVE_ARM_ARCH_TIMER
arch/arm/Kconfig:       select HAVE_ARM_ARCH_TIMER
arch/arm/Kconfig:config HAVE_ARM_ARCH_TIMER
arch/arm/mach-alpine/Kconfig:   select HAVE_ARM_ARCH_TIMER
arch/arm/mach-axxia/Kconfig:    select HAVE_ARM_ARCH_TIMER
arch/arm/mach-bcm/Kconfig:      select HAVE_ARM_ARCH_TIMER
arch/arm/mach-bcm/Kconfig:      select HAVE_ARM_ARCH_TIMER
arch/arm/mach-bcm/Kconfig:      select HAVE_ARM_ARCH_TIMER
arch/arm/mach-exynos/Kconfig:   select HAVE_ARM_ARCH_TIMER
arch/arm/mach-hisi/Kconfig:     select HAVE_ARM_ARCH_TIMER
arch/arm/mach-imx/Kconfig:      select HAVE_ARM_ARCH_TIMER
arch/arm/mach-keystone/Kconfig: select HAVE_ARM_ARCH_TIMER
arch/arm/mach-omap2/Kconfig:    select HAVE_ARM_ARCH_TIMER
arch/arm/mach-omap2/Kconfig:    select HAVE_ARM_ARCH_TIMER
arch/arm/mach-qcom/Kconfig:     select HAVE_ARM_ARCH_TIMER
arch/arm/mach-rockchip/Kconfig: select HAVE_ARM_ARCH_TIMER
arch/arm/mach-shmobile/Kconfig: select HAVE_ARM_ARCH_TIMER
arch/arm/mach-shmobile/Kconfig: select HAVE_ARM_ARCH_TIMER
arch/arm/mach-sunxi/Kconfig:    select HAVE_ARM_ARCH_TIMER
arch/arm/mach-tegra/Kconfig:    select HAVE_ARM_ARCH_TIMER
arch/arm/mach-tegra/Kconfig:    select HAVE_ARM_ARCH_TIMER

(`git kgrep' is aliased to `!git grep $* -- "*Kconf*"')

Looking at e.g. arch/arm/mach-omap2/Kconfig, a mixed omap 3/4/5
multi-platform kernel would have this enabled, too, while it was selected
for omap5 only.

If having this enabled in Kconfig causes regressions (on CA7 --- I don't have
a board with enabled CA7 support), the two patches should be reverted.

However, given CONFIG_HAVE_ARM_ARCH_TIMER was enabled in
shmobile_defconfig before, I believe such an issue on CA7 would have been
present before, when using shmobile_defconfig? Or were all CA7 users rolling
their own config files, not enabling it?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
