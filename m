From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 26 Mar 2013 15:37:21 +0000
Subject: Re: [PATCH 01/02] sh-pfc: Add r8a73a4 pinmux support
Message-Id: <2460623.2QgQLGp0hR@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <2774524.M2sxvGcfqv@avalon>
In-Reply-To: <2774524.M2sxvGcfqv@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Tuesday 26 March 2013 15:29:22 Magnus Damm wrote:
> On Thu, Mar 21, 2013 at 9:19 PM, Laurent Pinchart wrote:
> > On Monday 18 March 2013 23:50:39 Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >> 
> >> Add initial PFC support for the r8a73a4 SoC.
> >> 
> >> At this point only GPIO interface is supported, move to
> >> newer interfaces planned as incremental changes.
> > 
> > I'm fine with splitting PFC support for the r8a73a4 into a first patch
> > that implements the old API and incremental changes that move to the new
> > API, to making partial backporting easier. However, to avoid increasing my
> > already high work load related to the PFC driver, I don't want to push
> > this patchto mainline without the incremental changes that convert the
> > driver to the pinctrl API. Could you thus please submit a v2 that will
> > include pinctrl support ?
> 
> I am happy to add pinctrl support, especially when I get to control the
> timing myself.

That means I will finally have an opportunity to sleep a bit, thank you :-)

> > (I believe this summarizes the discussion we had yesterday, please let me
> > know if there had been any misunderstanding).
> 
> Yes, I believe it summarizes the discussion quite well. As for your
> requirement of incremental changes to get code merged, I hear what you're
> saying but after pondering about it a bit I must say this really doesn't
> make my life any easier. I would like to discuss more with you how to find a
> good middle ground without having to revert to primitive things like holding
> code hostage.

Sure, I'm open to discussion. Please keep in mind that this is an interim 
situation only, function GPIOs should soon turn into a distant memory of a bad 
nightmare for all new platforms :-)

> >> Original authors are Morimoto-san with help from Yoshii-san,
> >> thanks to them for the heavy lifting. Adjusted by Magnus
> >> to work together with updated code in drivers/pinctrl.
> >> 
> >> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >> Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> > 
> > The code looks OK to me. I don't have a copy of the r8a73a4 datasheet so I
> > can't verify all the details.
> 
> Thanks.
> 
> >> ---
> >> 
> >>  Written against "next" renesas.git
> >>  811689afc214564c4a5f238ecf4d8bdc0e52b615
> >> 
> >> Requires "r8a73a4.h" provided by
> >> 
> >>   [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V2
> >>  
> >>  arch/arm/mach-shmobile/include/mach/r8a73a4.h |  918 ++++++++
> >>  drivers/pinctrl/sh-pfc/Kconfig                |    5
> >>  drivers/pinctrl/sh-pfc/Makefile               |    1
> >>  drivers/pinctrl/sh-pfc/core.c                 |    3
> >>  drivers/pinctrl/sh-pfc/core.h                 |    1
> >>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c          | 2826 +++++++++++++++++++
> >>  6 files changed, 3754 insertions(+)
> > 
> > Could you please split this in two patches, one for arch/arm and one for
> > drivers/pinctrl ?
> 
> Do you mean this initial patch or the incremental PINCTRL ones? I've looked
> at your incremental r8a7779 changes and they seem to be implemented
> following such style.

I'm talking about this patch. My understanding is that patches should not 
touch arch/ and drivers/ at the same time unless strictly required.

> I'm happy to split out changes the same way you're doing. But like I
> mentioned above, I dislike being forced to add these as a requirement for
> upstream merge. I can however live with it, and prioritize this over for
> instance pending paperwork, not my problem. What I really don't want is to
> invest time into something by splitting out code and then you will ask for
> it all to be merged together like in the case of GPIO.

My preference would of course to go straight to the pinctrl API without going 
through function GPIOs. As this would make partial backporting more complex 
I'm OK with splitting the code in initial patches that add PFC + function 
GPIOs support and incremental patches that replace function GPIOs with a 
proper pinctrl implementation, as in your v2.

> Of course, with the same logic you can then squeeze together your own
> patches too and then everyone looses - especially anyone doing bisect. So I
> still think using a version control system with incremental changes has it's
> clear advantages, and if we can use it to track down the individual commit
> that's a nice feature to have. Especially when it comes to correctness about
> these things like pinmux tables.

I think there was a fundamental misunderstanding. I've never meant to advocate 
for all patches being squashed together. In the particular case of your GPIO 
patch set my point was that the intermediate version didn't bring any 
additional value and made the code more complex to review.

> Anyway, regarding splitting code and headers, I don't really understand why
> you want to split the header for the initial patch. I do however realize
> that there are dependencies that need to be handled. Can you outline exactly
> how you want it, and sync that with the party that will merge the code
> (Simon?)?

Simon might be able to provide more information here. As far as I understand 
touching both arch/arm/ and drivers/ in the same patch is discouraged.

> So to summarize, I will adjust to split the code any way the merging party
> wants it to be done. I'm not going to split it just for fun. =)
> 
> > The following comments apply to the pinctrl API only, they're hints for
> > the v2 mentioned above.
> > 
> >> --- 0006/arch/arm/mach-shmobile/include/mach/r8a73a4.h
> >> +++ work/arch/arm/mach-shmobile/include/mach/r8a73a4.h        2013-03-18
> >> 22:38:11.000000000 +0900 @@ -1,6 +1,924 @@
> >> 
> >>  #ifndef __ASM_R8A73A4_H__
> >>  #define __ASM_R8A73A4_H__
> >> 
> >> +/*
> >> + * Pin Function Controller:
> >> + *   GPIO_FN_xx - GPIO used to select pin function
> >> + *   GPIO_PORTxx - GPIO mapped to real I/O pin on CPU
> >> + */
> >> +enum {
> >> +
> >> +     /* PORT */
> >> +     GPIO_PORT0, GPIO_PORT1, GPIO_PORT2, GPIO_PORT3, GPIO_PORT4,
> >> +     GPIO_PORT5, GPIO_PORT6, GPIO_PORT7, GPIO_PORT8, GPIO_PORT9,
> > 
> > [snip]
> > 
> > The whole enum should be removed when moving to the pinctrl API. Port
> > numbers will be used directly instead of the GPIO_PORTx values.
> 
> Right, thanks for clarifying.
> 
> >> --- /dev/null
> >> +++ work/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c 2013-03-18
> > 
> > 22:44:53.000000000
> > 
> > [snip]
> > 
> >> +const struct sh_pfc_soc_info r8a73a4_pinmux_info = {
> >> +     .name           = "r8a73a4_pfc",
> >> +
> >> +     .input = { PINMUX_INPUT_BEGIN, PINMUX_INPUT_END },
> >> +     .input_pu = { PINMUX_INPUT_PULLUP_BEGIN, PINMUX_INPUT_PULLUP_END },
> >> +     .input_pd = { PINMUX_INPUT_PULLDOWN_BEGIN,
> >> PINMUX_INPUT_PULLDOWN_END },> 
> > PU/PD should be handled as in
> > 
> >         sh-pfc: sh73a0: Add bias (pull-up/down) pinconf support
> >         sh-pfc: sh73a0: Remove pull-up function GPIOS
> 
> Ok, thanks for the pointer.
> 
> >> +     .output = { PINMUX_OUTPUT_BEGIN, PINMUX_OUTPUT_END },
> >> +     .function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
> >> +
> >> +     .pins = pinmux_pins,
> >> +     .nr_pins = ARRAY_SIZE(pinmux_pins),
> > 
> > GPIO numbers are sparse, don't forget to add ranges as in
> > 
> >         ARM: shmobile: sh73a0: Support sparse GPIO numbers
> 
> Thanks.
> 
> >> +     .func_gpios = pinmux_func_gpios,
> >> +     .nr_func_gpios = ARRAY_SIZE(pinmux_func_gpios),
> > 
> > You should add functions for all the functions used by board code. See for
> > instance
> > 
> >         sh-pfc: sh7372: Add SDHCI and MMCIF pin groups and functions
> 
> I understand. The current board code is rather limited, so I guess it
> should be quite easy.
> 
> > Finally you should remove support for function GPIOs as in the following
> > patches (not in Simon's tree yet, they're available from my git tree at
> > git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/gpio)
> > 
> >         sh-pfc: r8a7779: Remove function GPIO
> >         sh-pfc: r8a7779: Don't use GPIO enum entries
> >         ARM: shmobile: r8a7779: Remove all GPIOs
> 
> Thanks for explaining how to move forward.

You're welcome.

-- 
Regards,

Laurent Pinchart

