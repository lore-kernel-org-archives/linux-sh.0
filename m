From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Dec 2014 09:14:28 +0000
Subject: Re: [PATCH v7 0/6] sh73a0 common clock framework implementation
Message-Id: <20141219091425.GA9634@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418222727-19888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418222727-19888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 19, 2014 at 09:04:44AM +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 19, 2014 at 12:48 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > As Mike has acked the first patch I would like to take the entire series
> >> > through my tree.
> >>
> >> OK... Less work for me ;-)
> >
> > :)
> >
> >> Will you also take the other clock related patches floating around?
> >> E.g. "[PATCH v2] clk: shmobile: div6: Avoid changing divisor in .disable()",
> >> and a few other adding support for more R-Car Gen2 SoCs?
> >
> > As Mike has indicated he will take them I do not plan to.
> 
> The above mentioned div6 patch is not the div6 patch in clk/for-next.
> This is a new one.

Thanks, I see that now.

I'm happy to take this if it is a dependency for other mach-shmobile
patches for v3.20. But it would need Mike's Ack.
