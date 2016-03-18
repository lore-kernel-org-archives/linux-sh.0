From: Simon Horman <horms@verge.net.au>
Date: Fri, 18 Mar 2016 00:18:55 +0000
Subject: Re: [RFC v4 1/4] watchdog: renesas-rwdt: add driver
Message-Id: <20160318001852.GA17140@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 17, 2016 at 10:48:29AM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
> 
> On Thu, Mar 17, 2016 at 10:34 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> > +Required properties:
> >> > +- compatible : Should be "renesas,rwdt-r8a7795";
> >>
> >> "renesas,r8a7795-rwdt", and "renesas,rcar-gen3-rwdt" as a fallback, to match
> >> current best practices?
> >
> > What about "renesas,rcar-gen2-rwdt" since Gen2 and Gen3 are identical?
> 
> Are they? :-) Yes, at the datasheet level, FWIW...

How about "renesas,rcar-gen2-rwdt" and "renesas,rcar-gen3-rwdt".
That way we have flexibility if the IP turns out to be different.
This is in keeping with the scheme I have been slowly rolling
out over various drivers for Renesas IP.

> > But why "r8a7795-rwdt" with SoC first? Looking at the r8a7795.dtsi,
> > "<ip_core>-<soc_type>" seems to be more dominant than
> > "<soc_type>-<ip_core>"? Ah, confusing again...
> 
> For new bindings, we follow practices set by the rest of the DT crowd.

+1
