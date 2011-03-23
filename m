From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 23 Mar 2011 14:54:53 +0000
Subject: Re: [PATCH 0/6] mmc: split the tmio driver into several modules
Message-Id: <20110323145453.GA12106@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange> <AANLkTi=EBDnRtjqN3eckpt32p-tG8VkcsktLartOEgBp@mail.gmail.com> <Pine.LNX.4.64.1103211226110.21013@axis700.grange> <20110322053127.GG27346@verge.net.au> <20110322122850.GA26099@linux-sh.org> <20110322220623.GJ2423@verge.net.au>
In-Reply-To: <20110322220623.GJ2423@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

On Wed, Mar 23, 2011 at 07:06:24AM +0900, Simon Horman wrote:
> By 1-3 I was referring to the first three patches of
> [PATCH 0/4] [rfc v3] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
> 
> That is:
> [PATCH 1/4] mmc: tmio_mmc: Move some defines into a shared header
> [PATCH 2/4] mmc, ARM: Rename SuperH Mobile ARM zboot helpers
> [PATCH 3/4] mmc: Add MMC_PROGRESS_*
> 
> And by patch 4 I was referring to
> [PATCH 4/4 v5] mmc, ARM: Add zboot from eSD support for SuperH Mobile
> 
> I apologise for that being as clear as mud.
> 
Ok, that makes a bit more sense, thanks for clearing it up.

> Magnus raised a build issue with the series since my previous email.
> I will investigate that and reply to him ASAP. Its probably best
> to hold all the patches until then.
> 
It looks like 1/4 is going to have to go through the MMC tree, and will
have to layer on top of Guennadi's current patch stack. He's done a good
job of summarizing the outstanding bits, so it should be trivial to build
on top of that.

Once 1/4 is merged I can easily merge 2 and 3/4 at pretty much any time
during the -rc window, although I'd prefer to have it sorted out by -rc2
or -rc3 at the latest. This will just leave 4/4 for rmk's patch tracker
and its respective scheduling.

For now I'll punt the series from patchwork and await a resend with 1/4
rebased in such a way that it can trivially be picked up by the MMC tree.

> With regards to 
> [PATCH 2/6] sh: ecovec: use the CONFIG_MMC_TMIO symbols instead of MFD
> it looks like Magnus raised a few issues and Guennadi is going to repost
> the patch. But I could be wrong.
> 
Yes, already dealt with separately.
