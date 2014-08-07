From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 07 Aug 2014 05:19:53 +0000
Subject: Re: [PATCH 1/5] i2c: rcar: add renesas,i2c-rcar-gen1/gen2 in DT compatible
Message-Id: <87zjfgkhae.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87silaw7t2.wl%kuninori.morimoto.gx@gmail.com>
	<87r40uw7rp.wl%kuninori.morimoto.gx@renesas.com>
	<20140807001805.GE32652@verge.net.au>
	<8761i5kuel.wl%kuninori.morimoto.gx@renesas.com>
	<20140807011025.GA3284@verge.net.au>
	<8738d9kojw.wl%kuninori.morimoto.gx@gmail.com>
	<CANqRtoSu2cZyY2YELUzPF86UAz+=TFtBYsnmotpNDEh9FEhp1Q@mail.gmail.com>
In-Reply-To: <CANqRtoSu2cZyY2YELUzPF86UAz+=TFtBYsnmotpNDEh9FEhp1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linux-SH <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


Hi Magnus

> The problem is that "gen2" is not something that is pre-defined. As
> you may have noticed earlier, new SoCs keep on coming and even though
> they may be part of "gen2" they may or may not be compatible with the
> "gen2" compatible string. So based on that, if we use the SoC part
> number in the compatible string we at least know what the support
> status is.

Do you mean "driver" table ?
This patch doesn't remove SoC level compatible from driver.

And additionally,
we can check support status in Document/devicetree/...txt
and Geert is doing it now ?
(Which SoC is working/supporting)

> So I agree that sharing hardware makes sense from a resource saving
> point of view. However in reality there may be smaller differences
> between devices used for each version within the generation though.

Yes, "maybe" it has smaller difference, but what is the problem ?
Driver is already have SoC level compatible.
Why we can't update it ?

Or, "maybe" we can add new property for it ?
It can keep compatible anyway, because current code is already working.

In my opinion, we can use SoC level compatible name if it was special,
otherwise, we can use generation level compatible.
Platform side DTS file should include SoC and generation level compatible
from first support patch. If possible, series compatible too.
like this

	compatible = "renesas,i2c-r8a7790", "renesas,i2c-rcar-gen2", "renesas,i2c-rcar"

But, it is too late for Gen1/Gen2.
I don't want to have more pointless string in driver in Gen3 or later.

But yes, we want to know which SoC is supported.
We can use Document/devicetree/...txt for this purpose

Best regards
---
Kuninori Morimoto
