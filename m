From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Nov 2010 06:22:37 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb: add fsib 44100Hz rate fixup
Message-Id: <w3paal9rdn7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> >  	case 44100:
> >  		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 11283000));
> > +		clk_set_rate(fdiv_clk, clk_round_rate(fsib_clk, 11283000));
> 
> 
> Shouldn't this be 
> 
> 	clk_set_rate(fdiv_clk, clk_round_rate(fdiv_clk, 11283000));

clk_round_rate(fsib_clk, 11283000) is correct.
this mean fdiv_clk no divide.

should I modify like this ?

 	case 44100:
		rate = clk_round_rate(fsib_clk, 11283000);
         	clk_set_rate(fsib_clk, rate);
		clk_set_rate(fdiv_clk, rate);


Best regards
--
Kuninori Morimoto
 
