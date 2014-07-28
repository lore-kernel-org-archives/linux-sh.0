From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 28 Jul 2014 08:33:43 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: Protect register accesses with a	spinlock instead of a mutex
Message-Id: <87tx619927.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1406150366-10169-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<87y4vja9xq.wl%kuninori.morimoto.gx@renesas.com>
	<87tx67a4cf.wl%kuninori.morimoto.gx@gmail.com>
	<53D5E6C2.3060607@metafoo.de>
	<87vbqi7wy1.wl%kuninori.morimoto.gx@renesas.com>
	<53D603C6.5070408@metafoo.de>
In-Reply-To: <53D603C6.5070408@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


Hi Lars

> > But it (= base address mapping was not fixed between Gen1 and Gen2)
> > was the reason why I was asked to use regmap_fields
> >
> 
> I think that is fine. But you are only using a single regmap instance even 
> though there are multiple unrelated register maps used and then you specify 
> the offset in the regmap_fields as a absolute address. This is supposed to 
> be a relative offset to the base address.
> 
> So basically use: ".reg = offset" instead of ".reg = (unsigned 
> int)gen->base[reg_id] + offset" and when creating the field instead of 
> passing a global regmap instance pass the regmap instance for the register 
> map in who's range the register falls.

Hmm... I re-checked it, and I could understand.
And, indeed it was hackish.
OK, I try to modify it, then, it seems can use regmap-mmio.

