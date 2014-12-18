From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Dec 2014 23:48:18 +0000
Subject: Re: [PATCH v7 0/6] sh73a0 common clock framework implementation
Message-Id: <20141218234818.GB29188@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418222727-19888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418222727-19888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 18, 2014 at 09:09:59AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Dec 18, 2014 at 4:01 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Dec 17, 2014 at 01:39:09PM +0200, Laurent Pinchart wrote:
> >> On Wednesday 17 December 2014 09:01:10 Geert Uytterhoeven wrote:
> >> > On Wed, Dec 17, 2014 at 8:54 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >> > > This series looks like it has been receiving both plenty of review and
> >> > > testing. What's your plan regarding merge?
> >> >
> >> > I plan to collect all clk-related patches in a branch, and ask Mike to pull
> >> > it (after New year).
> >> >
> >> > Is that OK?
> >
> > As Mike has acked the first patch I would like to take the entire series
> > through my tree.
> 
> OK... Less work for me ;-)

:)

> Will you also take the other clock related patches floating around?
> E.g. "[PATCH v2] clk: shmobile: div6: Avoid changing divisor in .disable()",
> and a few other adding support for more R-Car Gen2 SoCs?

As Mike has indicated he will take them I do not plan to.

I do notice that although he indicated that he would take them they
do not seem to be in Linus's tree or next. I'm not sure if Mike is
following this thread any more. But it would be good to get those changes
in, one way or another.
