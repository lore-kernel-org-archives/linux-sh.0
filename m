From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 05 Jul 2013 07:12:36 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a73a4: reorganise device instantiation in DT case
Message-Id: <CANqRtoS+QHXUKcBo639zJ01-KV3fmYXWfAoc3hYQQpbzx=dquQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372970438-21549-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372970438-21549-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi again Guennadi,

On Fri, Jul 5, 2013 at 3:36 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi Guennadi,
>
> On Fri, Jul 5, 2013 at 3:25 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
>> On Fri, 5 Jul 2013, Magnus Damm wrote:
>>
>>> Hi Guennadi,
>>>
>>> On Fri, Jul 5, 2013 at 2:55 PM, Guennadi Liakhovetski
>>> <g.liakhovetski@gmx.de> wrote:
>>> > Hi Magnus
>>> >
>>> > On Fri, 5 Jul 2013, Magnus Damm wrote:
>>> >
>>> >> Hi Guennadi,
>>> >>
>>> >> On Fri, Jul 5, 2013 at 5:40 AM, Guennadi Liakhovetski
>>> >> <g.liakhovetski@gmx.de> wrote:
>>> >> > Extract serial interface and CMT device instantiation into a separate
>>> >> > function to be called in both full DT and dummy DT modes. This doesn't
>>> >> > change the behaviour in the dummy DT case, only the instantiation order
>>> >> > changes slightly. The full DT case is extended, previously these devices
>>> >> > were not available there. Also following the r8a7790 example we remove the
>>> >> > call to of_platform_populate() from the exported method to let platforms
>>> >> > extend its parameters if needed.
>>> >> >
>>> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>>> >> > ---
>>> >> >  arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1 +
>>> >> >  arch/arm/mach-shmobile/setup-r8a73a4.c        |   17 ++++++++++++++---
>>> >> >  2 files changed, 15 insertions(+), 3 deletions(-)
>>> >> >
>>> >> > diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
>>> >> > index 12a4ee9..2266747 100644
>>> >> > --- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
>>> >> > +++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
>>> >> > @@ -17,6 +17,7 @@ enum {
>>> >> >  };
>>> >> >
>>> >> >  void r8a73a4_add_standard_devices(void);
>>> >> > +void r8a73a4_add_standard_devices_dt(void);
>>> >> >  void r8a73a4_clock_init(void);
>>> >> >  void r8a73a4_pinmux_init(void);
>>> >> >  void r8a73a4_init_delay(void);
>>> >> > diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
>>> >> > index 6aa80645..52bf60c 100644
>>> >> > --- a/arch/arm/mach-shmobile/setup-r8a73a4.c
>>> >> > +++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
>>> >> > @@ -302,7 +302,7 @@ static struct resource dma_resources[] = {
>>> >> >         },
>>> >> >  };
>>> >> >
>>> >> > -void __init r8a73a4_add_standard_devices(void)
>>> >> > +static void __init r8a73a4_add_common_devices(void)
>>> >> >  {
>>> >> >         r8a73a4_register_scif(SCIFA0);
>>> >> >         r8a73a4_register_scif(SCIFA1);
>>> >> > @@ -310,10 +310,15 @@ void __init r8a73a4_add_standard_devices(void)
>>> >> >         r8a73a4_register_scif(SCIFB1);
>>> >> >         r8a73a4_register_scif(SCIFB2);
>>> >> >         r8a73a4_register_scif(SCIFB3);
>>> >> > +       r8a7790_register_cmt(10);
>>> >> > +}
>>> >> > +
>>> >> > +void __init r8a73a4_add_standard_devices(void)
>>> >> > +{
>>> >> >         r8a73a4_register_irqc(0);
>>> >> >         r8a73a4_register_irqc(1);
>>> >> > +       r8a73a4_add_common_devices();
>>> >> >         r8a73a4_register_thermal();
>>> >> > -       r8a7790_register_cmt(10);
>>> >> >         platform_device_register_resndata(&platform_bus, "sh-dma-engine", 0,
>>> >> >                                 dma_resources, ARRAY_SIZE(dma_resources),
>>> >> >                                 &dma_platform_data, sizeof(dma_platform_data));
>>> >> > @@ -329,7 +334,13 @@ void __init r8a73a4_init_delay(void)
>>> >> >  #ifdef CONFIG_USE_OF
>>> >> >  void __init r8a73a4_add_standard_devices_dt(void)
>>> >> >  {
>>> >> > +       r8a73a4_add_common_devices();
>>> >> >         platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
>>> >> > +}
>>> >> > +
>>> >> > +static void __init add_devices_dt(void)
>>> >> > +{
>>> >> > +       r8a73a4_add_standard_devices_dt();
>>> >> >         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>> >> >  }
>>> >> >
>>> >> > @@ -340,7 +351,7 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
>>> >> >
>>> >> >  DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
>>> >> >         .init_early     = r8a73a4_init_delay,
>>> >> > -       .init_machine   = r8a73a4_add_standard_devices_dt,
>>> >> > +       .init_machine   = add_devices_dt,
>>> >> >         .init_time      = shmobile_timer_init,
>>> >> >         .dt_compat      = r8a73a4_boards_compat_dt,
>>> >> >  MACHINE_END
>>> >>
>>> >> Thanks for you efforts on this, but despite what the change log says
>>> >> (what is dummy DT?), doesn't this change the behaviour of
>>> >> ->init_machine() above? It looks like you add platform devices to me,
>>> >> which is exactly what I don't want.
>>> >
>>> > Sure, I can remove this line, and do it differently, but let's see why I
>>> > did that:
>>> >
>>> > As the commit message says, I tried to model this patch set after the
>>> > recent similar series from Simon:
>>> >
>>> > http://thread.gmane.org/gmane.linux.ports.sh.devel/24711
>>>
>>> This is an old version of that patch. Use the latest version.
>>
>> Sorry, wrong link, here's the correct one:
>>
>> http://www.spinics.net/lists/arm-kernel/msg256585.html
>
> There are so many wrongs here so I am hoping to see one right soon.
>
>> and I did base on that one. As you can see - only this latest version
>> calls of_platform_populate() from the board, not the SoC code, which is
>> also what I do.
>
> I have no problem with of_platform_populate() from the board code.
>
> I simply don't want you to change the behaviour of ->init_machine() in
> setup-xxx.c.
>
> Look at this code:
>
> --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> @@ -179,7 +179,7 @@ static struct resource cmt00_resources[] = {
>    &cmt##idx##_platform_data, \
>    sizeof(struct sh_timer_config))
>
> -void __init r8a7790_add_standard_devices(void)
> +void __init r8a7790_add_dt_devices(void)
>  {
>   r8a7790_register_scif(SCIFA0);
>   r8a7790_register_scif(SCIFA1);
> @@ -191,9 +191,14 @@ void __init r8a7790_add_standard_devices(void)
>   r8a7790_register_scif(SCIF1);
>   r8a7790_register_scif(HSCIF0);
>   r8a7790_register_scif(HSCIF1);
> + r8a7790_register_cmt(00);
> +}
> +
> +void __init r8a7790_add_standard_devices(void)
> +{
> + r8a7790_add_dt_devices();
>   r8a7790_register_irqc(0);
>   r8a7790_register_thermal();
> - r8a7790_register_cmt(00);
>  }
>
>  void __init r8a7790_timer_init(void)
>
> Above Simon is adding r8a7790_add_dt_devices(). That's not what you
> are doing in your code.
>
>>> > which, I understand, should be a real example to follow, when doing this.
>>> > In that patch .init_machine() is used for Lager to call
>>> > r8a7790_add_standard_devices_dt(). That function existed before on
>>> > r8a7790, but, I believe, was unused. So, Simon has extended it to
>>> > initialise clocks and add some standard devices from the SoC data.
>>> >
>>> > I did the same: I call r8a73a4_add_standard_devices_dt() from ape6evm's
>>> > .init_machine(). I also extended r8a73a4_add_standard_devices_dt() to add
>>> > some common devices from SoC code. But the difference with r8a7790 is,
>>> > that that function is also used by the r8a73a4 "generic" board. So, I took
>>> > the liberty to also add those devices to the generic case. Ok, if that's
>>> > not desired, I can remove that. But my reasoning was - if board-specific
>>> > DT boots can do that, why cannot the generic one do that as well? One more
>>> > change I did to that function was removing of_platform_populate() from it
>>> > and making calling it each board's own task - again, similar to r8a7790.
>>>
>>> Whatever, learn to use the most recent code.
>>
>> I did, so, my comments / questions hold, I assume.
>
> Whatever again, I am sorry to say this, but at this point I don't care
> about your reasons.
>
> I simply asked you to write APE6EVM DT reference code and follow the
> Lager DT reference style. Which apparently was too difficult.
>
> For these patches the signal to noise ratio is _way_ too high for my
> liking. Just rewrite your code and move on with life.
>
>>> >> I'd like ->init_machine() to become NULL, but  above it seems that I
>>> >> overlooked the odd commit when platform_device_register_simple() was
>>> >> added. So ideally I'd like that non-standard
>>> >> platform_device_register_simple() to simply go away, but that is out
>>> >> of scope for this change I believe. So I'm not sure about the point of
>>> >> the above hunks.
>>> >>
>>> >> As mentioned earlier, please model this change following Simon's Lager
>>> >> DT reference support. Leave ->init_machine() in setup-r8a73a4.c
>>> >> untouched - no platform devices. If you need platform devices for
>>> >> certain things like SCIF and/or CMT then tie in callbacks from
>>> >> board-specific DT_MACHINE and do leave this SoC specific DT_MACHINE
>>> >> as-is.
>>> >>
>>> >> In a separate commit, please try to figure out what to do about that
>>> >> platform_device_register_simple() line.
>>> >
>>> > You mean the cpufreq device? What's wrong with it? Would you prefer to
>>> > have it added by each platform? Seems like suboptimal to me. Or add it in
>>> > DT? Not sure if that would work. And yes, I looked it up from some another
>>> > platform.
>>>
>>> So the DT_MACHINE callbacks in setup-xxx.c are supposed to handle the
>>> long term DT-only case. You are mixing DT and platform devices
>>> randomly, don't do that. Use DT in the case for DT, it's as simple as
>>> that.
>>
>> Ok, I'll leave the SoC case untouched. But the board code is allowed to
>> init clocks and add devices from its .init_machine()?
>
> What do you think? What does the Lager DT reference code from Simon do?

That last comment was a bit unkind, my apologies for that. This mess i
however driving me nuts.

The answer to your question is probably yes, but more likely "that
depends". See more below after 1-3.

- - -

We have 3 different DT_MACHINE definitions usually (2 per board and 1 for soc).

1. DT_MACHINE in setup-xxx.c

This is supposed to be the long term DT support for a single SoC that
we will use when we dump all other C board code and only rely on DT
for board support. This will be used together with common clocks and
multiplatform in the future. I don't want to have any platform
devices, early timers or early printk or any non-standard bits here.
Ideally all callbacks should be NULL here.

2. MACHINE or DT_MACHINE in board-yyy.c

This is where complete C-only board support is located. This board
support code may be back ported and used by people that want the
latest driver support even though certain DT bindings may not be
finalized yet. This is also a good place to do local non-upstream
prototype hacking if you're into that sort of thing. The old legacy SH
clock code is used here. Multiplatform will not be supported here. In
some cases GIC and SMP can be initialized via DT for this code, but
that will make back porting more difficult so it is not recommended
for the majority of the platforms. This C only board support code
should be replaced by the DT reference code described below, the
sooner the better.

3. DT_MACHINE in board-yyy-reference.c

This is the location for the DT board support used for incremental
development. The hardware support feature set here is limited
depending on how many drivers that have actual DT support. We want the
code to be DT only here. In some special cases it is however
acceptable to use platform devices (for instance serial consoles and
timers that lack DT bindings and are needed for boot). If for instance
clocks, pinctrl or gpio via DT aren't available for the particular SoC
then board specific setup in C can be used as a stop-gap solution
here. When common clocks become available this DT reference board
support will be used together with multiplatform. When DT reference
and C board code are on the same level and common clocks are available
then only DT_MACHINE in setup-xxx.c will be used.

- - -

So regarding your question, it is OK for board code to add clock setup
in C anywhere as long as common clocks are not yet implemented. As for
adding platform devices, I don't want any of those in DT reference
board code or DT_MACHINE in setup-xxx.c, but you can and should add
those in the C version of the board code. If they are SoC specific and
potentially shared across multiple boards then you can add them to
setup-xxx.c but make sure that the DT_MACHINE stuff there isn't using
any platform devices.

In the particular case of cpufreq, I expect a platform device to be
added to board-yyy.c or since it is a per-SoC property it may be
better to use setup-xxx.c. Please note that I don't want the
DT_MACHINE bits in setup-xxx.c to make use of that platform device,
instead a SoC specific function shall be used that can be called from
the C board code. Also, in parallel with platform device in C board
code you should add DT nodes for the DT reference board support.
Exactly how to share the per-SoC DT reference DTSI bits is a different
topic, but since we only have a single board for the majority of the
SoCs it's sort of a minor issue code duplication wise.

Hope this clarifies.

Thanks,

/ magnus
