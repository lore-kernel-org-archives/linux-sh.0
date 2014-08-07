From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Aug 2014 03:55:01 +0000
Subject: Re: [PATCH 1/5] i2c: rcar: add renesas,i2c-rcar-gen1/gen2 in DT compatible
Message-Id: <CANqRtoSu2cZyY2YELUzPF86UAz+=TFtBYsnmotpNDEh9FEhp1Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87silaw7t2.wl%kuninori.morimoto.gx@gmail.com>
	<87r40uw7rp.wl%kuninori.morimoto.gx@renesas.com>
	<20140807001805.GE32652@verge.net.au>
	<8761i5kuel.wl%kuninori.morimoto.gx@renesas.com>
	<20140807011025.GA3284@verge.net.au>
	<8738d9kojw.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8738d9kojw.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Linux-SH <linux-sh@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>

Hi Morimoto-san,

On Thu, Aug 7, 2014 at 11:43 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>
> Hi Simon
>
>> At our face-to-face meeting in Montpellier we discussed the
>> idea of generation bindings. And my recollection is that Magnus
>> and I had strong reservations about declaring what generation compatibility
>> is without it being explicitly stated in hardware documentation.
>>
>> From observation we can say that the i2c controllers on r8a7778 and r8a7779
>> appear to be compatible. But can we say that in fact they are in fact
>> compatible hardware. That they are different hardware instances of a common
>> i2c controller whose name may or may not be is known to us? If not
>> I do not think that using a common binding describes the hardware,
>> which is the intention of DT bindings.
>>
>> A second problem is the using the generation as a name.  Assuming the
>> answer to the above question is yes can we further say with certainty
>> that all variants of Gen1 SoCs that currently exist or will exist in the
>> future are compatible?  If not then using Gen1 as the name does not seem
>> to accurately describe the hardware.
>
> This is the reason why SoC side have multi compatible name ?
> My understanding is that, generation compatibility support
> common feature, SoC compatibility support specific feature.
>
>        compatible = "renesas,i2c-r8a7790", renesas,i2c-rcar-gen2"
>
> If r8a7790 has special feature, then, it match to first compatible name
> (or it can have special property)
> If it is same as other Gen2, then, it can match to 2nd name.

The problem is that "gen2" is not something that is pre-defined. As
you may have noticed earlier, new SoCs keep on coming and even though
they may be part of "gen2" they may or may not be compatible with the
"gen2" compatible string. So based on that, if we use the SoC part
number in the compatible string we at least know what the support
status is.

> HW doesn't have IP specific version, but latest datasheet
> is indicating all H2/M2/E2/V2.
> And, from HW team point of view, they don't want to create
> same name but multi feature IP in same generation.
> Creating and Testing new IP needs too much time / money / paper work.

So I agree that sharing hardware makes sense from a resource saving
point of view. However in reality there may be smaller differences
between devices used for each version within the generation though.

Now, if we could get the hardware version number from the device team
somehow....

Thanks,

/ magnus
