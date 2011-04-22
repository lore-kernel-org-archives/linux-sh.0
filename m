From: Paul Parsons <lost.distance@yahoo.com>
Date: Fri, 22 Apr 2011 11:13:02 +0000
Subject: Re: [PATCH] MMC: tmio: fix a recent regression: restore .set_ios(MMC_POWER_UP) handling
Message-Id: <57837.39952.qm@web29020.mail.ird.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
References: <504862.26396.qm@web29015.mail.ird.yahoo.com>
In-Reply-To: <504862.26396.qm@web29015.mail.ird.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>

--- On Fri, 22/4/11, Paul Parsons <lost.distance@yahoo.com> wrote:
> As far as I can see the expression
> 
> (ios->clock = 0 && ios->power_mode =
> MMC_POWER_ON)
> 
> will only be true if host->f_init = 0 at the time
> MMC_POWER_ON is invoked in mmc_power_up(). Presumably that
> case is intentional.

Sorry, ignore this; I missed the case where mmc_gate_clock() sets ios->clock = 0 before calling mmc_set_ios().
