From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 29 Nov 2013 01:43:31 +0000
Subject: Re: [PATCH v3 06/15] ARM: shmobile: koelsch-reference: Initialize CPG device
Message-Id: <CANqRtoTXOodMLQB0Y_nOU4YXaTHzG-pz+Y1HktdSjfieLw-RjQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385600632-5181-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385600632-5181-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Fri, Nov 29, 2013 at 2:17 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Thursday 28 November 2013 14:32:18 Magnus Damm wrote:
>> On Thu, Nov 28, 2013 at 10:03 AM, Laurent Pinchart wrote:
>> > On multiplatform kernels clocks are handled by the CCF CPG driver. It
>> > must be explicitly initialized by a call to rcar_gen2_clocks_init() with
>> > the value of the boot mode pins.
>> >
>> > Signed-off-by: Laurent Pinchart
>> > <laurent.pinchart+renesas@ideasonboard.com>
>>
>> Hi Laurent,
>>
>> Thanks for your efforts. I think this series looks very nice in
>> general. Please see below for two questions.
>>
>> > --- a/arch/arm/mach-shmobile/board-koelsch-reference.c
>> > +++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
>> > @@ -46,7 +52,7 @@ static const char * const koelsch_boards_compat_dt[]
>> > __initconst = {>
>> >  DT_MACHINE_START(KOELSCH_DT, "koelsch")
>> >
>> >         .smp            = smp_ops(r8a7791_smp_ops),
>> >         .init_early     = r8a7791_init_early,
>> >
>> > -       .init_time      = rcar_gen2_timer_init,
>> > +       .init_time      = koelsch_init_time,
>> >
>> >         .init_machine   = koelsch_add_standard_devices,
>> >         .init_late      = shmobile_init_late,
>> >         .dt_compat      = koelsch_boards_compat_dt,
>>
>> What is the reason that you need to initialize CCF at ->init_time()?
>> We used to initialize timers early in the legacy board case but for DT
>> we've so far been able to initialize timers late. Is it really time to
>> go back again? =)
>
> rcar_gen2_timer_init() calls clocksource_of_init(), and our clocksource
> devices need clocks, so CCF needs to be initialized before that.

Well, I can see where you are coming from, and your assumption sounds
sane. But I don't think your logic is a matching reality! =)

Our timer drivers like CMT, TMU, MTU2 and STI are all using the good
old regular platform device driver model for probe(). They do not rely
on the clocksource_of_init() probe mechanism. The reason for this is
that they were written before clocksource_of_init() was introduced.
Actually, I'm sure there is a reason behind it, but I don't see the
point of this duplicated OF-specific interface at all, but that's a
different story.

The ARM drivers like TWD and arch timer do however rely on
clocksource_of_init(), but they can all be used without the clock
framework unless I'm mistaken, so you don't have any dependency there.

It is my opinion that we should use the regular driver model for our
timers. If there is some issue with that then we should for instance
be able to use deferred probing to remedy that.

Some of our legacy board code is using early platform devices for
early timers. But all DT reference board code with legacy clocks is
setting up timers late. Because of this I believe it is very possible
to init the timers late with CCF as well.

So from my point of view we should avoid enabling CCF early, it just
makes things complicated with no apparent upside.

>> As for initializing the CCF, if we go down the route of early CCF
>> init, can't you put your CCF init call at one shared location in for
>> instance rcar_gen2_timer_init()?
>
> That's a good idea, I will do that.

Thanks. Since I believe it is possible to use late CCF init then I
much prefer using that. But feel free to prove me wrong!

Cheers,

/ magnus
