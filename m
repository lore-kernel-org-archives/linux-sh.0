From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 21 Jun 2012 11:42:49 +0000
Subject: Re: [PATCH 01/11] ARM: mach-shmobile: add a temporary macro to define fixed voltage regulators
Message-Id: <201206211342.49936.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1340179300-16452-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340179300-16452-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, June 20, 2012, Mark Brown wrote:
> On Wed, Jun 20, 2012 at 10:01:30AM +0200, Guennadi Liakhovetski wrote:
> > Providing fixed voltage permanently "on" regulators with different voltages
> > shares a lot of identical code. It will be eliminated, once the
> > regulator_register_fixed_volt() function becomes available. Until then we
> > introduce a macro to define such regulators. This helps reduce the amount
> > of added code in each platform file and keeps copy-paste errors to the
> > minumum.
> 
> Or you could just pull in the topic branch I created for the purpose of
> allowing other trees to pick this up:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/topic/fixed
> 
> which should save everyone work all round.  Just don't rebase.

Arnd, Olof,

Would it be fine with you if we merged the topic branch above into
our soc branch?

Rafael
