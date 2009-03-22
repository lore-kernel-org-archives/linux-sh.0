From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 22 Mar 2009 11:01:50 +0000
Subject: Re: Kernel fails on Dreamcast - results of bisection
Message-Id: <20090322110149.GA1226@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1237675045.27611.23.camel@localhost.localdomain>
In-Reply-To: <1237675045.27611.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Mar 21, 2009 at 11:39:25PM +0000, Adrian McMenamin wrote:
> On Sat, 2009-03-21 at 22:37 +0000, Adrian McMenamin wrote:
> > I bisected the kernel in your (Paul's) git as I knew that it was not
> > working well on the Dreamcast 
> ....
> 
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
> >     sh: rework clocksource and sched_clock
> >     
> >     Rework and simplify the sched_clock and clocksource code. Instead
> >     of registering the clocksource in a shared file we move it into the
> >     tmu driver. Also, add code to handle sched_clock in the case of no
> >     clocksource.
> >     
> >     Signed-off-by: Magnus Damm <damm@igel.co.jp>
> >     Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> > 
> > 
> 
> To test this further I reverted this commit and it does indeed seem to
> fix the problem - the next line on the console in systems that boot (as
> opposed to fail) is indeed one about the System Clock.
> 
> (I am now getting a lot of messages about failures of the udev script -
> possibly because I have just turned a lot of debugging stuff on - in any
> case the system does boot and works with that commit reverted).
> 
> I don't pretend to know why Magnus's patch is breaking the Dreamcast,
> but I am pretty sure it is. Could it be reverted before being pushed
> upstream while we wait for one that works?
> 
Please test with it reverted and with no changes to the defconfig. If you
are randomly going to change variables, then the bug report is
speculation at best. If you are going to make config changes at the same
time that you revert changes, you are not debugging the problem at hand.
It is not even worth looking at this until you are sure the same scenario
exists without config changes.
