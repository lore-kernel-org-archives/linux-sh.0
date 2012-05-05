From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 05 May 2012 07:22:45 +0000
Subject: Re: [PATCH 00/02] mach-shmobile: Emma Mobile EV2 - first shot
Message-Id: <201205050722.45500.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20120503144645.6390.62303.sendpatchset@w520>
 <201205041957.14205.arnd@arndb.de> <201205042316.55593.rjw@sisk.pl>
In-Reply-To: <201205042316.55593.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 04 May 2012, Rafael J. Wysocki wrote:
> I'm not sure if I understand your point correctly, so please let me clarify.
> 
> Do you think it's better to have a separate mach-emma directory for the
> new hardware because technically it is a different platform and the fact
> that it was developed by the same manufacturer as the mach-shmobile hardware
> is less important?

Yes, that was my point. Compare this to how we have omap and davinci for TI,
orion and pxa for Marvell, or mxs and imx for Freescale. These are all
for the most part independent developments that happened to end up being
owned by the same company.

We try to group code based on technical similarities, not on who makes them.
If you are able to share code between multiple completely independent socs
you work on, the result shouldn't be to put them into a directory you "own",
but to generalize the common parts so they can be shared with everyone else,
too.

	Arnd
