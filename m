From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Dec 2014 15:46:59 +0000
Subject: Re: [PATCH] clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <CANqRtoTXuxnVbZjn0cTfqJwUQdoW7F9d1_O1tRkk57fCmwn3Sw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141216094854.22639.69181.sendpatchset@w520>
In-Reply-To: <20141216094854.22639.69181.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Dec 17, 2014 at 11:43 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Geert,
>
> On Wednesday 17 December 2014 14:59:21 Geert Uytterhoeven wrote:
>> On Wed, Dec 17, 2014 at 1:14 PM, Laurent Pinchart wrote:
>> >>> What are we missing ?
>> >>>
>> >>> - The DIV6 multiparent series has been merged by Mike, and the sh73a0
>> >>> CCF is nearly ready.
>> >>
>> >> Yep.
>> >>
>> >>> - We need proper BSC support to get LAN working, although it could be
>> >>> worked around temporarily by specifying the BSC clock in the LAN node
>> >>> if I recall correctly.
>> >>
>> >> Working on that. I hope to send out v2 later today...
>> >>
>> >>> - Accelerometer and RTC have no DT bindings, but they should work with
>> >>> the I2C core OF match support.
>> >>
>> >> I have RTC in my DTS, and it works.
>> >
>> > Great.
>> >
>> > I can help with at least some of the remaining pieces if you share your
>> > working branch.
>>
>> I pushed my local working branch to
>> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/?
>> h=wip
>>
>> Please wear sun glasses, and keep the kbuild test robot away ;-)
>
> I will :-) Thank you. Is there a way to selectively keep kbuild away from
> branches by the way ?
>
> Do avoid duplicating work, what do you plan to work on in the context of
> multiplatform kzm9g ?
>
> Magnus, how much time do you think would be worth spending on DT support for
> the lcdc drm driver ?

Not much, but perhaps it is good to have a working separate reference
implementation if it can be done with little effort.

I guess if you can re-use the LCDC driver between sh73a0 and r8a7740
then there may be _some_ point, but unless I'm mistaken the sh73a0 has
the LCDC interrupt only routed to INTCS which in turn lacks DT
support. Not sure if r8a7740 is any better - at least it has the GIC
together with the Cortex-A9.

Cheers,

/ magnus
