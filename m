From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Aug 2014 05:58:16 +0000
Subject: Re: [PATCH 1/5] i2c: rcar: add renesas,i2c-rcar-gen1/gen2 in DT compatible
Message-Id: <CANqRtoR1kn0VjDiYy24hJueeL6Lxs5yxAeTEMQ-kNHn76EYMDQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87silaw7t2.wl%kuninori.morimoto.gx@gmail.com>
	<87r40uw7rp.wl%kuninori.morimoto.gx@renesas.com>
	<20140807001805.GE32652@verge.net.au>
	<8761i5kuel.wl%kuninori.morimoto.gx@renesas.com>
	<20140807011025.GA3284@verge.net.au>
	<8738d9kojw.wl%kuninori.morimoto.gx@gmail.com>
	<CANqRtoSu2cZyY2YELUzPF86UAz+=TFtBYsnmotpNDEh9FEhp1Q@mail.gmail.com>
	<87zjfgkhae.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87zjfgkhae.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Linux-SH <linux-sh@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>

Hi Morimoto-san,

Thanks for your comments!

On Thu, Aug 7, 2014 at 2:19 PM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>
> Hi Magnus
>
>> The problem is that "gen2" is not something that is pre-defined. As
>> you may have noticed earlier, new SoCs keep on coming and even though
>> they may be part of "gen2" they may or may not be compatible with the
>> "gen2" compatible string. So based on that, if we use the SoC part
>> number in the compatible string we at least know what the support
>> status is.
>
> Do you mean "driver" table ?
> This patch doesn't remove SoC level compatible from driver.

Yes, this applies to the compatible string table in each driver.
Because "gen2" is an ongoing project we have no idea what kind of new
products that will come out - that may or may not be compatible with
the "gen2" current compatible strings... And these strings are only
really specifying if our current version of the driver is compatible
or not. We should instead describe the hardware dependency IMO.

> And additionally,
> we can check support status in Document/devicetree/...txt
> and Geert is doing it now ?
> (Which SoC is working/supporting)

Right, that is good!

My main concern is not the support status though. It is more about how
to handle the "gen2" compatible string over time. Please see below for
some example of difficulties introduced by this approach.

>> So I agree that sharing hardware makes sense from a resource saving
>> point of view. However in reality there may be smaller differences
>> between devices used for each version within the generation though.
>
> Yes, "maybe" it has smaller difference, but what is the problem ?
> Driver is already have SoC level compatible.
> Why we can't update it ?

We can of course update anything, the question is just why we should. =)

> Or, "maybe" we can add new property for it ?
> It can keep compatible anyway, because current code is already working.

In my opinion having a "gen2" compatible string in the driver does not
help anything. For the existing SoCs we already have compatible
strings. For new SoCs we can simply add the new part number to the
driver.

Perhaps you are thinking about the case when new "compatible" SoCs
come out, the idea that we want to not modify the driver but just add
DTS and then everything should work as-is. This is a great idea, and
for this to work we want to have "hardware block version number" from
the device team. Until we have that I believe it is best to not use
"gen2" compatible strings. Let me explain why.

1) We don't know if the hardware is compatible unless it is documented to be so
2) We can test using the same compatible string, but it just means the
current driver implementation happens to work
3) If all registers and features are used by the driver then we can
perhaps assume that we have tested the hardware
4) The common case with a driver is that not all hardware features are
used, so some are untested and unknown compatibility wise
5) If we use "gen2" compatible string then future driver feature
extensions may break some hardware
6) To avoid breakage in 5) we have test on all known platforms which
is quite difficult
7) People will ship out of tree code using the generic binding so we
cannot perform testing in 6) on all platforms
8) The meaning of "gen2" is changing over time, so it is not a fixed
definition of anything
9) In the end, this discussion is matter of describing compatibility
of hardware or software implementation.
10) DT bindings should in theory work with multiple operating systems.
So we have to describe hardware, not software.

With this in mind I think the best way forward is as follows:
A) Keep on using per-SoC compatible string unless it is documented somewhere
and in parallel
B) Work on getting per-device hardware version number from hardware device team

> In my opinion, we can use SoC level compatible name if it was special,
> otherwise, we can use generation level compatible.
> Platform side DTS file should include SoC and generation level compatible
> from first support patch. If possible, series compatible too.
> like this
>
>         compatible = "renesas,i2c-r8a7790", "renesas,i2c-rcar-gen2", "renesas,i2c-rcar"
>
> But, it is too late for Gen1/Gen2.
> I don't want to have more pointless string in driver in Gen3 or later.

I understand your opinion. I don't want to have pointless strings in
new SoCs either.

From my point of view your proposal adds problematic dependencies for
each device without too much upside. The problem will happen over time
when adding features. It is in my opinion easier to just add the
compatible string entry for a new SoC together with the rest of the
SoC support activity. There is no easy way out when the hardware is
changing - we have to modify the code anyway! Of course, if the
hardware is not changing then it is a different story. But in such
case we need to have documented compatibility somewhere...

What is your opinion about "B) per-device hardware version number"?

> But yes, we want to know which SoC is supported.
> We can use Document/devicetree/...txt for this purpose

I agree about that portion. =)

Cheers,

/ magnus
