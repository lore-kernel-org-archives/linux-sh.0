From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 30 May 2012 00:25:27 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: tidyup: sound card detection order
Message-Id: <87txyy347i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4rmqzd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4rmqzd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for your reply

> > And I'm not sure ALSA already has index specification method.
> > Sorry for my confusion.
> > My problem was deferred probe order on built-in.
> 
> I was under the impression that the index could be set for a built-in too.
> But poking around in /sys on an armadillo board, that seems not to be the
> case.

I guess on /sys index is depends on .id ? 
In mackerel case, it is

static struct platform_device fsi_ak4643_device = {
	.name	= "asoc-simple-card",
        ...
}

static struct platform_device fsi_hdmi_device = {
	.name	= "asoc-simple-card",
	.id	= 1,
        ...
}

# fsi_ak4643_device didn't have .id = 0, but it is.

Does these appear on /sys ?

Now, platform_device order are

static struct platform_device *mackerel_devices[] __initdata = {
	...
	&fsi_ak4643_device,  // .id = 0
	&fsi_hdmi_device,    // .id = 1
	...
}

ALSA sound card list order is same as detected/probed order, not these .id order.

> > Current my issue is...
> >   normal probe of ALSA-card.0  -> requests probe deferral
> >   normal probe of ALSA-card.1  -> requests probe deferral
> >   ...
> >   deferred-probe of ALSA-card.1  <= order changed
> >   deferred-probe of ALSA-card.0  <= order changed

So, if this happen, ALSA-card list order become un-expected order.

> I'm not entirely sure it makes any sense to be relying on the
> order of cards being initialised. But I guess the order of
> initialisation is relied on in other places too.

It decides "1st player", "2nd player".
I'm expecting "fsi_ak4643" is 1st player, but...

Best regards
---
Kuninori Morimoto
