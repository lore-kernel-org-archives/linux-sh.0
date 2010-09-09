From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 09 Sep 2010 03:56:24 +0000
Subject: Re: [PATCH 4/4 v2] ARM: mach-shmobile: ap4evb: Add HDMI sound support
Message-Id: <w3pzkvro9i0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3py6bn5o6m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3py6bn5o6m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Guennadi

> > +	switch (rate) {
> > +	case 48000:
> > +		clk_set_rate(clk, clk_round_rate(clk, 85428000));
> > +		__raw_writel(0x00070003, base + 0x8);
> 
> Hm, these two registers seem to be a perfect candidate for the clock API?

Do you mean I should use new struct clk for this operation
like fsiackcr_clk ?

Best regards
--
Kuninori Morimoto
 
