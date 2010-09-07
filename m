From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 07 Sep 2010 10:02:55 +0000
Subject: Re: [PATCH 2/4 v2] ASoC: Add sh_mobile_hdmi sound support
Message-Id: <20100907100255.GC7886@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
	<w3pwrr75o6d.wl%kuninori.morimoto.gx@renesas.com>
	<Pine.LNX.4.64.1009060932430.20387@axis700.grange>
	<20100906102557.GE10367@rakim.wolfsonmicro.main>
	<Pine.LNX.4.64.1009070910370.1345@axis700.grange>
	<20100907094047.GA7886@rakim.wolfsonmicro.main>
	<Pine.LNX.4.64.1009071152330.1345@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009071152330.1345@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>

On Tue, Sep 07, 2010 at 11:56:34AM +0200, Guennadi Liakhovetski wrote:
> On Tue, 7 Sep 2010, Mark Brown wrote:

> > Could you please be more explicit here?  Register I/O needs to happen
> > somehow...

> Sorry, maybe I am missing something, but my understanding is, that the 
> ASoC core knows nothing about codec's specific register layout, so, the 
> core itself cannot initiate any register IO. So, I presume, there can be 
> only two instances, that can do that - the codec driver itself and some 
> user-space (debugging) programs. The driver doesn't use cached register 
> accesses, so, it can access the registers directly, and it doesn't have to 
> provide an ability to the user-space to access registers - if it chooses 
> so. So, I don't see, who should be trying to use generic ASoC register 
> access routines here.

All register I/O, cached or not, is supposed to go through the register
I/O operations.  Any cache is abstraced away within those operations.
Since the driver presumably needs do do some I/O (even if only in the
hw_params() you have identified as missing) I would expect it to provide
register I/O functionality.
