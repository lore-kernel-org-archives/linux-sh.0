From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 28 Jul 2014 08:03:18 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: Protect register accesses with a	spinlock instead of a mutex
Message-Id: <53D603C6.5070408@metafoo.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1406150366-10169-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>	<87y4vja9xq.wl%kuninori.morimoto.gx@renesas.com>	<87tx67a4cf.wl%kuninori.morimoto.gx@gmail.com>	<53D5E6C2.3060607@metafoo.de> <87vbqi7wy1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbqi7wy1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On 07/28/2014 09:40 AM, Kuninori Morimoto wrote:
>
> Hi Lars
> # added Mark
>
>>> Hmm... rsnd driver is using "regmap_field".
>>> regmap-mmio  requests "offset"  on "reg"
>>> regmap-filed requests "address" on "reg"
>>>
>>> So, if rsnd driver uses regmap-mmio,
>>> then, it needs tricky initialize like...
>>>
>>>         regmap_init_mmio(dev, 0, config)
>>>
>>
>> Create one regmap instance per base address and in the regmap_fields use an
>> relative offset to the base address rather than the absolute address. That's
>> how the API is intended to be used, the current implementation is quite a hack.
>
> Hmm...
> But it (= base address mapping was not fixed between Gen1 and Gen2)
> was the reason why I was asked to use regmap_fields
>

I think that is fine. But you are only using a single regmap instance even 
though there are multiple unrelated register maps used and then you specify 
the offset in the regmap_fields as a absolute address. This is supposed to 
be a relative offset to the base address.

So basically use: ".reg = offset" instead of ".reg = (unsigned 
int)gen->base[reg_id] + offset" and when creating the field instead of 
passing a global regmap instance pass the regmap instance for the register 
map in who's range the register falls.


- Lars
