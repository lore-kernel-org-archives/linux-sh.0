From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 28 Jul 2014 05:59:30 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: Protect register accesses with a	spinlock instead of a mutex
Message-Id: <53D5E6C2.3060607@metafoo.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1406150366-10169-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <87y4vja9xq.wl%kuninori.morimoto.gx@renesas.com> <87tx67a4cf.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87tx67a4cf.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org

On 07/24/2014 04:16 AM, Kuninori Morimoto wrote:
>
> Hi Laurent
>
>>> The hardware registers are accessed from atomic contexts (the
>>> rsnd_soc_dai_trigger function, for instance, is called with the PCM
>>> substream spinlock held). They thus can't be protected by a mutex.
>>>
>>> Protect regmap register accesses with a spinlock instead of a mutex by
>>> setting the fast_io flag.
>>>
>>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>> ---
>>>   sound/soc/sh/rcar/gen.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> An even better solution might be to use regmap-mmio instead of a custom bus.
>>> Morimoto-san, is there anything that would prevent the driver from switching
>>> to regmap-mmio ?
>>
>> I guess it is possilbe to use regmap-mmio.
>> I check it.
>
> Hmm... rsnd driver is using "regmap_field".
> regmap-mmio  requests "offset"  on "reg"
> regmap-filed requests "address" on "reg"
>
> So, if rsnd driver uses regmap-mmio,
> then, it needs tricky initialize like...
>
>        regmap_init_mmio(dev, 0, config)
>

Create one regmap instance per base address and in the regmap_fields use an 
relative offset to the base address rather than the absolute address. That's 
how the API is intended to be used, the current implementation is quite a hack.

- Lars

