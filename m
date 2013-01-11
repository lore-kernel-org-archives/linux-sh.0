From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Jan 2013 01:30:25 +0000
Subject: Re: [PATCH v2] sh: clkfwk: bugfix: sh_clk_div_enable() care sh_clk_div_set_rate() if div6
Message-Id: <87wqvk4ic1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9u4x5q1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9u4x5q1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

I still couldn't find this patch on linus/master branch.
What is current status of this ?

At Tue, 27 Nov 2012 10:33:38 +0900,
Paul Mundt wrote:
> 
> On Mon, Nov 26, 2012 at 04:45:45PM -0800, Kuninori Morimoto wrote:
> > 
> > Hi Paul
> > 
> > > > 764f4e4e33d18cde4dcaf8a0d860b749c6d6d08b
> > > > (sh: clkfwk: Use shared sh_clk_div_enable/disable())
> > > > shared enable/disable funcions for div4/div6.
> > > > But new sh_clk_div_enable() didn't care sh_clk_div_set_rate()
> > > > which is required on div6 clock.
> > > > This patch fixes it.
> > > > 
> > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > Looks better, I'll queue it up, thanks.
> > 
> > Thanks.
> > Is it possible to go to v3.7-rcX ?
> > 
> Yes, should be fine.


Best regards
---
Kuninori Morimoto
