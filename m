From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 28 Aug 2014 10:36:39 +0000
Subject: Re: [PATCH v4] mmc: tmio: ensure that the clock has been stopped before set_clock
Message-Id: <87vbpchpe1.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>
	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>
	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>
	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>
	<53AD638C.5060907@renesas.com>
	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
	<87bnr9tgwj.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFrzr_tjLFqZ1nQg63Zfr0xRAf71HWAmge6DcMzTkwCLiQ@mail.gmail.com>
	<87bnr5ic6h.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFo2rv-33cgEx+uGnpkDfDDTQfSmLOiAA3Eb=mrfeRab9w@mail.gmail.com>
	<CAPDyKFqUdC5a72rgDPk4HnQJoMe9qkfMPTFnFG+wXuSjMB2jbw@mail.gmail.com>
In-Reply-To: <CAPDyKFqUdC5a72rgDPk4HnQJoMe9qkfMPTFnFG+wXuSjMB2jbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Ulf

> > I don't think this is needed. Let me elaborate on why.
> >
> > There two scenarios for when you may come down this path.
> >
> > Either after ->probe() or after a MMC_POWER_OFF has been handled. In
> > both scenarios, tmio_mmc_clk_stop(host) has already been invoked.
> >
> > Well, actually in the ->probe() we invoke tmio_mmc_clk_stop() and then
> > tmio_mmc_reset(), should those maybe be done in reverse order to make
> > sure the clock is stopped?
(snip)
> > To get runtime PM resumed, you must first be runtime PM suspended. In
> > the runtime PM suspend callback we have already invoked
> > tmio_mmc_set_clock().

I see
Thank you for you detail explain about that

Best regards
---
Kuninori Morimoto
