From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 16 Nov 2011 22:25:51 +0000
Subject: Re: sh7372 compile breakage in current -next
Message-Id: <201111162325.51517.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, November 16, 2011, Rafael J. Wysocki wrote:
> On Wednesday, November 16, 2011, Guennadi Liakhovetski wrote:
> > arch/arm/mach-shmobile/pm-sh7372.c: In function 'sh7372_pm_init':
> > arch/arm/mach-shmobile/pm-sh7372.c:476: error: 'sh7372_a3sp' undeclared (first use in this function)
> > arch/arm/mach-shmobile/pm-sh7372.c:476: error: (Each undeclared identifier is reported only once
> > arch/arm/mach-shmobile/pm-sh7372.c:476: error: for each function it appears in.)
> > make[2]: *** [arch/arm/mach-shmobile/pm-sh7372.o] Error 1
> 
> OK, I'll have a look at that.
> 
> What's the .config you used?

Do you have CONFIG_PM unset, perchance?

Rafael
