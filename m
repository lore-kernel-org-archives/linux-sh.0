From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Thu, 26 Mar 2009 00:01:55 +0000
Subject: Re: Kernel fails on Dreamcast - results of bisection
Message-Id: <1238025715.12857.5.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1237675045.27611.23.camel@localhost.localdomain>
In-Reply-To: <1237675045.27611.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 2009-03-23 at 12:49 +0900, Magnus Damm wrote:
> On Sun, Mar 22, 2009 at 7:37 AM, Adrian McMenamin
> <adrian@newgolddream.dyndns.info> wrote:
> > This is the result of the bisection. I cannot see what bit of this patch
> > is causing the difficulties but I'm pretty sure that this is where it
> > is. The actual problem is a race condition, as it does not happen on
> > every boot...
> >
> > adrian@bossclass:~/lethal-repo$ git bisect good
> > 955c0778723501cc16fec40501cd54b7e72d3e74 is first bad commit
> > commit 955c0778723501cc16fec40501cd54b7e72d3e74
> > Author: Magnus Damm <damm@igel.co.jp>
> > Date:   Thu Jan 22 09:55:31 2009 +0000
> >
> >    sh: rework clocksource and sched_clock
> >
> >    Rework and simplify the sched_clock and clocksource code. Instead
> >    of registering the clocksource in a shared file we move it into the
> >    tmu driver. Also, add code to handle sched_clock in the case of no
> >    clocksource.
> >
> >    Signed-off-by: Magnus Damm <damm@igel.co.jp>
> >    Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 
> Unless you have some dreamcast specific timer dependencies I really
> doubt that this patch is the cause of your problems. How about
> creating a smaller kernel? Take the defconfig and remove for instance
> cpufreq, mtd and all filesystems except whatever your rootfs is on.
> 


Well, I have done that and got the same results. I cannot actually
reproduce the udev script breakage, but can reproduce the OOM condition.

But I'll wait until all this is sucked into the .30-rc series and try
another bisection. The previous one was difficult because so many of the
bisected kernels were a priori broken due to issues with DMA that meant
make files had to be hacked to get them beyond an immediate breakage and
to the point where the OOM condition might be observed.

Whilst this wasn't an issue at the end of the process (ie the kernel
waiting to go into mainline doesn't have this DMA issue) it my be that
the true source of the breakage has been obscured.

When we get to the rc series I am assuming that won't be an issue...

