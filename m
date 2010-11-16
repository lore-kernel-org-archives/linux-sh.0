From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Nov 2010 06:24:36 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb: add fsib 44100Hz rate fixup
Message-Id: <20101116062436.GA1330@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 16, 2010 at 03:22:37PM +0900, Kuninori Morimoto wrote:
> 
> Dear Paul
> 
> > >  	case 44100:
> > >  		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 11283000));
> > > +		clk_set_rate(fdiv_clk, clk_round_rate(fsib_clk, 11283000));
> > 
> > 
> > Shouldn't this be 
> > 
> > 	clk_set_rate(fdiv_clk, clk_round_rate(fdiv_clk, 11283000));
> 
> clk_round_rate(fsib_clk, 11283000) is correct.
> this mean fdiv_clk no divide.
> 
> should I modify like this ?
> 
>  	case 44100:
> 		rate = clk_round_rate(fsib_clk, 11283000);
>          	clk_set_rate(fsib_clk, rate);
> 		clk_set_rate(fdiv_clk, rate);
> 
Yes, that would be cleaner. It would also be nice if you provided some
changeset comments so it's more apparent what you're trying to do.
