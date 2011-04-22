From: Paul Parsons <lost.distance@yahoo.com>
Date: Fri, 22 Apr 2011 04:24:35 +0000
Subject: Re: [PATCH] MMC: tmio: fix a recent regression: restore .set_ios(MMC_POWER_UP) handling
Message-Id: <504862.26396.qm@web29015.mail.ird.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
References: <m37hanaa7n.fsf@pullcord.laptop.org>
In-Reply-To: <m37hanaa7n.fsf@pullcord.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>

Yes, Guennadi's patch fixes my problem.

As far as I can see the expression

(ios->clock = 0 && ios->power_mode = MMC_POWER_ON)

will only be true if host->f_init = 0 at the time MMC_POWER_ON is invoked in mmc_power_up(). Presumably that case is intentional.

--- On Thu, 21/4/11, Chris Ball <cjb@laptop.org> wrote:
> Paul Parsons (CC'd) submitted a similar patch to fix the
> same regression.
> Paul, please could you check that Guennadi's patch fixes
> your problem?

