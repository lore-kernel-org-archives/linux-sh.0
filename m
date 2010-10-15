From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 15 Oct 2010 15:50:42 +0000
Subject: Re: [PATCH 3/3] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock support
Message-Id: <20101015155042.GA14975@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pk4lk11gd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pk4lk11gd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 15, 2010 at 06:39:23PM +0900, Paul Mundt wrote:
> On Fri, Oct 15, 2010 at 03:42:55PM +0900, Kuninori Morimoto wrote:
> > So, the table size will be 8 x 65535 = 512K byte if FSIDIV have it.
> > (ex) div6 case is 8 x 64 = 512 byte
> >      div4 case is 8 x 16 = 128 byte
> > 
> > I thought 512K byte is too big for kernel.
> > 
> Ok, that's certainly a valid reason. As we'll presumably see more of
> these in the future, how about something like this?
> 
> +#define for_each_frequency(pos, r, freq)			\
> +	for (pos = r->min, freq = r->func(pos, r->arg);		\
> +	     pos < r->max; pos++, freq = r->func(pos, r))	\
> +		if (unlikely(freq = 0))			\
> +			;					\
> +		else
> +
Oops, the first r->arg needs to be changed to r or you'll blow up on the
table rounding. I've got all of these in my sh/clkfwk topic branch if you
simply wish to test that.
