From: Simon Horman <horms@verge.net.au>
Date: Tue, 19 Jan 2016 09:27:28 +0000
Subject: Re: [PATCH/RFC 2/6] boot-mode-reg: Add R-Car Gen2 driver
Message-Id: <20160119092728.GA20683@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 19, 2016 at 09:01:38AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Jan 19, 2016 at 1:30 AM, Simon Horman <horms@verge.net.au> wrote:
> > In rcar_gen2_timer_init() I think we can replace the use of boot mode pins
> > with use of extal frequency from DT, as suggested earlier from Laurent.
> 
> Indeed. And it's really the extal frequency we need there, not the mode pin
> configuration.

Agreed.

> > An implication of that is that we could infer the boot mode settings
> > from the extal frequency and then use that in rcar_gen2_cpg_clocks_init().
> > Though I'm not sure how we would transmit the information from
> > rcar_gen2_timer_init() to rcar_gen2_cpg_clocks_init().
> 
> Deriving the mode pin configuration from the extal frequency sounds backwards
> to me. What if a non-standard crystal is used, like on Salvator-X?

I meant to say that it seems a bit awkward in my previous email.
You've pointed out a good reason why.
