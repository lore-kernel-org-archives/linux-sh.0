From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Mar 2013 17:09:12 +0000
Subject: Re: [PATCH 01/02] sh-pfc: Add r8a73a4 pinmux support
Message-Id: <CANqRtoSKd5qhz7i08b9bu0FNRY2i4KVksiwHdYKDbkj=K2gejQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2774524.M2sxvGcfqv@avalon>
In-Reply-To: <2774524.M2sxvGcfqv@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Mar 27, 2013 at 12:37 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Tuesday 26 March 2013 15:29:22 Magnus Damm wrote:
>> On Thu, Mar 21, 2013 at 9:19 PM, Laurent Pinchart wrote:
>> > On Monday 18 March 2013 23:50:39 Magnus Damm wrote:
>> >> From: Magnus Damm <damm@opensource.se>
>> >>
>> >> Add initial PFC support for the r8a73a4 SoC.
>> >>
>> >> At this point only GPIO interface is supported, move to
>> >> newer interfaces planned as incremental changes.
>> >
>> > I'm fine with splitting PFC support for the r8a73a4 into a first patch
>> > that implements the old API and incremental changes that move to the new
>> > API, to making partial backporting easier. However, to avoid increasing my
>> > already high work load related to the PFC driver, I don't want to push
>> > this patchto mainline without the incremental changes that convert the
>> > driver to the pinctrl API. Could you thus please submit a v2 that will
>> > include pinctrl support ?
>>
>> I am happy to add pinctrl support, especially when I get to control the
>> timing myself.
>
> That means I will finally have an opportunity to sleep a bit, thank you :-)

You can sleep all you want when you're old! =)

>> > (I believe this summarizes the discussion we had yesterday, please let me
>> > know if there had been any misunderstanding).
>>
>> Yes, I believe it summarizes the discussion quite well. As for your
>> requirement of incremental changes to get code merged, I hear what you're
>> saying but after pondering about it a bit I must say this really doesn't
>> make my life any easier. I would like to discuss more with you how to find a
>> good middle ground without having to revert to primitive things like holding
>> code hostage.
>
> Sure, I'm open to discussion. Please keep in mind that this is an interim
> situation only, function GPIOs should soon turn into a distant memory of a bad
> nightmare for all new platforms :-)

I agree that new platforms should be converted. Regarding nightmares,
you should have seen the PFC setup code that was spread out across the
board code soon 5 years ago before I introduced (the now hopefully
soon replaced) function GPIO abstraction. =)

>> >> Original authors are Morimoto-san with help from Yoshii-san,
>> >> thanks to them for the heavy lifting. Adjusted by Magnus
>> >> to work together with updated code in drivers/pinctrl.
>> >>
>> >> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> >> Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
>> >> Signed-off-by: Magnus Damm <damm@opensource.se>
>> >
>> > The code looks OK to me. I don't have a copy of the r8a73a4 datasheet so I
>> > can't verify all the details.
>>
>> Thanks.
>>
>> >> ---
>> >>
>> >>  Written against "next" renesas.git
>> >>  811689afc214564c4a5f238ecf4d8bdc0e52b615
>> >>
>> >> Requires "r8a73a4.h" provided by
>> >>
>> >>   [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V2
>> >>
>> >>  arch/arm/mach-shmobile/include/mach/r8a73a4.h |  918 ++++++++
>> >>  drivers/pinctrl/sh-pfc/Kconfig                |    5
>> >>  drivers/pinctrl/sh-pfc/Makefile               |    1
>> >>  drivers/pinctrl/sh-pfc/core.c                 |    3
>> >>  drivers/pinctrl/sh-pfc/core.h                 |    1
>> >>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c          | 2826 +++++++++++++++++++
>> >>  6 files changed, 3754 insertions(+)
>> >
>> > Could you please split this in two patches, one for arch/arm and one for
>> > drivers/pinctrl ?
>>
>> Do you mean this initial patch or the incremental PINCTRL ones? I've looked
>> at your incremental r8a7779 changes and they seem to be implemented
>> following such style.
>
> I'm talking about this patch. My understanding is that patches should not
> touch arch/ and drivers/ at the same time unless strictly required.

I agree that it's nice as long as you can avoid that.

Actually, I would prefer not to not have the enums in that location at
all. When the PFC tables were kept under arch/arm/mach-shmobile I
didn't mind so much having the PFC enums in include files under mach/,
but once they were moved out into driver/pinctrl/sh-pfc/ we still
seemed to keep those includes under mach/. Of course, the goal is to
remove the enums in the long run so perhaps it doesn't make much sense
to first move them to soon after remove them.

>> I'm happy to split out changes the same way you're doing. But like I
>> mentioned above, I dislike being forced to add these as a requirement for
>> upstream merge. I can however live with it, and prioritize this over for
>> instance pending paperwork, not my problem. What I really don't want is to
>> invest time into something by splitting out code and then you will ask for
>> it all to be merged together like in the case of GPIO.
>
> My preference would of course to go straight to the pinctrl API without going
> through function GPIOs. As this would make partial backporting more complex
> I'm OK with splitting the code in initial patches that add PFC + function
> GPIOs support and incremental patches that replace function GPIOs with a
> proper pinctrl implementation, as in your v2.

I would also prefer to go straight to the pinctrl API, but as you said
about the back porting...

>> Of course, with the same logic you can then squeeze together your own
>> patches too and then everyone looses - especially anyone doing bisect. So I
>> still think using a version control system with incremental changes has it's
>> clear advantages, and if we can use it to track down the individual commit
>> that's a nice feature to have. Especially when it comes to correctness about
>> these things like pinmux tables.
>
> I think there was a fundamental misunderstanding. I've never meant to advocate
> for all patches being squashed together. In the particular case of your GPIO
> patch set my point was that the intermediate version didn't bring any
> additional value and made the code more complex to review.

Ok, I think I understand better now.

I'm not sure, but you may find it odd that I broke out that particular
devm patch. But I've done so for other drivers earlier without any
review problems. Also, please note that I kept the devm stuff separate
because I was earlier recommended to do so to minimize back porting
dependencies.

Good thing was that you did clarify that such separation wasn't needed
anymore, so in the end it turned out that folding it in didn't hurt.

>> Thanks for explaining how to move forward.
>
> You're welcome.

Thanks for your help!

/ magnus
