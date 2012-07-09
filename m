From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 09 Jul 2012 16:53:19 +0000
Subject: Re: ARM: mach-shmobile: recent next build failure
Message-Id: <201207091853.19815.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207081101110.31002@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207081101110.31002@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, July 09, 2012, Magnus Damm wrote:
> On Mon, Jul 9, 2012 at 6:37 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Sunday, July 08, 2012, Rafael J. Wysocki wrote:
> >> On Sunday, July 08, 2012, Rafael J. Wysocki wrote:
> >> > On Sunday, July 08, 2012, Guennadi Liakhovetski wrote:
> >> > > Hi
> >> > >
> >> > > Got this build failure with Friday's next:
> >> > >
> >> > > linux/arch/arm/mach-shmobile/pm-sh7372.c: In function 'sh7372_pm_init':
> >> > > linux/arch/arm/mach-shmobile/pm-sh7372.c:598: error: implicit declaration of function 'sh7372_suspend_init'
> >> > > linux/arch/arm/mach-shmobile/pm-sh7372.c:599: error: implicit declaration of function 'sh7372_cpuidle_init'
> >> > > make[2]: *** [arch/arm/mach-shmobile/pm-sh7372.o] Error 1
> >> > >
> >> > > .config available on request.
> >> >
> >> > Please attach.
> 
> Guennadi, can you please share? Giving build error reports without
> kernel configuration or information about the problematic kconfig
> parameters is not very helpful at all.
> 
> If you are worried about attaching large files, why don't you use the
> "savedefconfig" make traget?
> 
> >> > Magnus, that appears to be a result of your recent wakeup changes.
> >>
> >> Guennadi, does the appended patch fix the problem for you?
> >
> > Well, scratch that, it's not so simple.
> >
> > The patch below should help instead.
> 
> It looks like you are trying to fix the cpu_resume() and cpu_suspend()
> mess. Thanks!
> 
> I somehow thought that the cpu_resume()/cpu_suspend() issue was solved
> already, but obviously that's not the case. My feeling is that I think
> we should try to fix it on a higher level. This because more or less
> all our SoCs that use low level sleep code will have to share it
> between Suspend-to-RAM and CPUIdle.
> 
> Also, I wonder if what you are seeing is the same issue as Guennadi?
> Let's wait for Guennadi to share his kernel configuration...

I'm quite sure it is, perhaps with a slight modification that Guennadi
had both CONFIG_PM and CONFIG_CPU_IDLE unset.  However, fixing that
particular case alone leads to a build problem when CONFIG_PM is unset
and CONFIG_CPU_IDLE is set.

Thanks,
Rafael
