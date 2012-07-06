From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 06 Jul 2012 20:32:16 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: fix platsmp.c build when ARCH_SH73A0=n
Message-Id: <201207062232.16715.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20120706082005.30495.53308.sendpatchset@w520>
In-Reply-To: <20120706082005.30495.53308.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday, July 06, 2012, Arnd Bergmann wrote:
> On Friday 06 July 2012, Rafael J. Wysocki wrote:
> > > 
> > > It can actually be written a little nicer now, like
> > > 
> > > #define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2() || \
> > >                        (IS_ENABLED(CONFIG_ARCH_SH73A0) && \
> > > 			of_machine_is_compatible("renesas,sh73a0")))
> > > 
> > > but that won't work for the backport and it's still a little
> > > ugly.
> > 
> > Can you please take the $subject patch directly to the fixes branch?
> > Or do you want me to generate a pull request with just this one patch?
> 
> Ok, applied to the fixes branch. My current plan is to send that branch
> upstream on Monday.
> 
> I've added Simon's Tested-by tag and I'm taking your mail as an Acked-by.

Yes, thanks a lot!

Rafael
