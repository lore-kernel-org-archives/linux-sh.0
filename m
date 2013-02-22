From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 22 Feb 2013 23:07:21 +0000
Subject: Re: [PATCH 1/3] serial: sh-sci: Add Device Tree probing
Message-Id: <CANqRtoQbByHowo77f4m91yYEY1GFQW1wCzce25cT9rmQi3AbNw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1361298586-30357-2-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1361298586-30357-2-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

On Fri, Feb 22, 2013 at 9:51 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> Hi Bastian,
>
> On Thu, Feb 21, 2013 at 12:11:58PM -0600, Bastian Hecht wrote:
>> 2013/2/21 Paul Mundt <lethal@linux-sh.org>:
>> > So something along the lines of:
>> >         renesas,sci-<port type>
>> >
>> > with or without a trailing -uart should work fine.
>>
>> Ok so I use
>> - compatible : Should be "renesas,sci-<port type>-uart", where <port
>> type> may be
>>   SCI, SCIF, IRDA, SCIFA or SCIFB.
>>
>> I will forward the type using the .data field as suggested.
>>
> Ok.
>
>> Further I introduce an optional regtype property
>> - regtype : Overwrite the register layout. Some hardware versions use
>> a non-default register layout. Possible layouts are
>>   0 = SCIx_SH2_SCIF_FIFODATA_REGTYPE
>>   1 = SCIx_SH3_SCIF_REGTYPE
>>   2 = SCIx_SH4_SCIF_REGTYPE
>>   3 = SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE
>>   4 = SCIx_SH4_SCIF_FIFODATA_REGTYPE
>>   5 = SCIx_SH7705_SCIF_REGTYPE
>>
>> Are the enum names good or should it be like "0 =  SH hardware version
>> 2 SCIF using FIFODATA"?
>>
> The enum names should be fine. I admit they aren't the most descriptive,
> but they're the best I could come up with on short notice, and any new
> SoC implementor should be able to easily figure it out by looking at the
> driver.
>
>> Further I'll add the fields
>> - scscr : Should contain a bitfield used by the Serial Control Register.
>>   b0 = SCSCR_TIE
>>   b1 = SCSCR_RIE
>>   b2 = SCSCR_TE
>>   b3 = SCSCR_RE
>>   b4 = SCSCR_REIE
>>   b5 = SCSCR_TOIE
>>   b6 = SCSCR_CKE1
>>   b7 = SCSCR_CKE0
>> - scbrr-algo-id : Algorithm ID for the Bit Rate Register
>>   1 = ((clk + 16 * bps) / (16 * bps) - 1)
>>   2 = ((clk + 16 * bps) / (32 * bps) - 1)
>>   3 = (((clk * 2) + 16 * bps) / (16 * bps) - 1)
>>   4 = (((clk * 2) + 16 * bps) / (32 * bps) - 1)
>>   5 = (((clk * 1000 / 32) / bps) - 1)
>>
> Ok.
>
>> What I am unsure about is how to deal with the .flags field. There are
>> 28 different possible UPF_* flags. Should I just add
>> - ioremap : Set this flag if I/O should be remapped.
>> - autoconf : Set if device is capable of auto configuration.
>>
> I guess the thing you have to figure out is whether it's sane to support
> non-remapped cases for the ARM side or not. On the SH side we can handle
> unconditional ioremap, even in the 1:1 case, but traditionally we didn't
> use it, so it was always an optional thing.
>
> If it simplifies things for you to say that DT use implies UPF_IOREMAP,
> that should be fine. How do other platforms deal with UPF flags?

Refraining from exposing software implementation details in DT is
probably a good idea. At least from my point of view the lack of or
need for ioremap is something that depends on the availability of
software-defined configuration like fixmaps and such. As you know, not
using ioremap allows us to output data on the serial console early
during boot. With DT that seems quite far away though, so assuming
ioremap will always be used makes sense IMO.

>> > I don't think the two are at odds. We already have an abstraction in
>> > place for dealing with this information, and it does need to be
>> > provideded by the platform. Hacking it in to the serial driver is not an
>> > acceptable solution, simply because you happen to be using the device
>> > tree.
>>
>> Ok so if this is the philosophy to go, I will throw my idea over board
>> to store setup data in the driver.
>>
>> > If it's really the case that you can use one or two definitions on all of
>> > the boards, then it should be no problem having a tiny .dtsi file with
>> > these definitions that you include in the platform's .dts file.
>>
>> Ok I get the idea.
>>
>> >> If I don't get something wrong, Magnus prefers to use the .data field
>> >> of the struct of_device_id to hide SoC specific parts from the
>> >> external visible bindings, if there is only 1 legal way to setup the
>> >> device. I personally prefer the .data way - but I don't want to be a
>> >> 3rd person joining the discussion. I'd prefer a decision. So please
>> >> Magnus, comment on this issue. I have no problem going either way.
>> >>
>> > I don't have any strong opinions on how .data gets used, but we will not
>> > be applying anything that adds arbitrary plat_sci_port definitions to the
>> > driver, as that is nothing but lazy and shortsighted.
>>
>> Uhmm... if you insist keep the "shortsighted", but I would replace the
>> laziness with "lack of experience".
>> I coded it the way I did because I thought it's the cleanest solution
>> - but I'm willing to learn.
>
> I apologize if I seem a bit abrupt over this matter, but it's a road that
> we have been down with this driver before, and it's taken years to get
> away from that model and in to something more flexible. I don't expect
> you to be fully aware of the history, so this wasn't directed at you
> specifically so much as just the general approach. Magnus should of
> course know better, but that's another matter entirely.

What should I know better?

My general approach is to make sure hardware-block specific bits are
kept separate from soc specific bits that also should be separated
from board. This is pretty basic stuff but it seems that I can keep on
repeating it forever. Also I don't want any software implementation
specific configuration to be leaked into the DT bits.

In this particular case I wanted to make sure Bastian didn't start
adding soc-specific stuff in the SCIF driver. So I am not very fond of
any data with sh77.... or r8a.. prefix in the driver and I know that
neither are you.

Regarding the other bits - I would be happy to leave the rest to you
guys. I am fine with most things - including if for instance the
correct way forward is a bunch of flags or more like grouped-together
configurations represented as hardware block version.

Thanks,

/ magnus
