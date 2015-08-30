From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Sun, 30 Aug 2015 23:43:49 +0000
Subject: Re: [PATCH][RFC] sh-pfc: add new PINMUX_IPSR_MODS() macro
Message-Id: <87io7w4a7u.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9nkc7km.wl%kuninori.morimoto.gx@renesas.com>
	<38944168.Lsx7EbeIaO@avalon>
In-Reply-To: <38944168.Lsx7EbeIaO@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


Hi Laurent

> > 	PINMUX_IPSR_NOGP(ispr, ...)
> > 	PINMUX_IPSR_DATA(ipsr, ...)
> > 	PINMUX_IPSR_NOGM(ispr, ...)
> > 	PINMUX_IPSR_NOFN(ipsr, ...)
> > 	PINMUX_IPSR_MSEL(ipsr, ...)
> > 	PINMUX_IPSR_MODSEL_DATA(ipsr, ...)
> > 
> > These are readable
> > 
> > 	PINMUX_IPSR_NOGP(ispr, ...)
> > 	PINMUX_IPSR_DATA(ipsr, ...)
> > 	PINMUX_IPSR_NOGM(ispr, ...)
> > 	PINMUX_IPSR_NOFN(ipsr, ...)
> > 	PINMUX_IPSR_MSEL(ipsr, ...)
> > 	PINMUX_IPSR_MODS(ipsr, ...)
> > 
> > We can replace all PINMUX_IPSR_MODSEL_DATA() to PINMUX_IPSR_MODS(),
> > and remove PINMUX_IPSR_MODSEL_DATA() from header.
> 
> I agree that the PINMUX_IPSR_MODSEL_DATA() name makes code harder to read. 
> However, PINMUX_IPSR_MODS() isn't very descriptive, I think it would make the 
> code confusing (not that it isn't already...).
> 
> The only difference between  PINMUX_IPSR_MSEL and PINMUX_IPSR_MODSEL_DATA is 
> the order in which the MODSEL, GSPR and IPSR registers are written. I wonder 
> if that's actually important, or if we could merge both macros into a single 
> one. What do you think ?

Yes, I agree about this.
But, PINMUX_IPSR_MSEL is used on r8a7778 only, and my concern is we don't know what happen
if we merged PINMUX_IPSR_MODSEL_DATA() and PINMUX_IPSR_MSEL()
And, I don't have bockw board now...
