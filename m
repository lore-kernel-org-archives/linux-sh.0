From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Feb 2010 00:51:33 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: G4EVM KEYSC platform data
Message-Id: <20100224005133.GA17581@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B83B40E.5040203@renesas.com>
In-Reply-To: <4B83B40E.5040203@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 24, 2010 at 09:03:38AM +0900, Kuninori Morimoto wrote:
> > @@ -82,6 +87,8 @@ static struct clk_lookup lookups[] = {
> >  		.clk = &r_clk,
> >  	}, {
> >  		.clk = &usb0_clk,
> > +	}, {
> > +		.clk = &keysc0_clk,
> >  	}
> >  };
> 
> I think above settings are already done on Magnus's patch
> 
> Subject: [PATCH] ARM: mach-shmobile: G3EVM KEYSC platform data
> 
> This patch still isn't applied though  =)
> 
It is blocked on changes from the input tree. I usually do at least two
merges doing the merge window, so I'll roll this in with the second
bunch once the merge dependencies have been resolved.
