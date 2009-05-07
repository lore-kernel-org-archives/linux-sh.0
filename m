From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 07 May 2009 09:19:06 +0000
Subject: Re: 2.6.30-rc4-git: timer-related oops
Message-Id: <20090507091906.GA26125@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090504091430.GA30660@linux-sh.org>
In-Reply-To: <20090504091430.GA30660@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 05, 2009 at 07:44:48AM +0200, Manuel Lauss wrote:
> On Mon, May 04, 2009 at 11:41:38PM +0900, Paul Mundt wrote:
> > On Mon, May 04, 2009 at 04:14:46PM +0200, Manuel Lauss wrote:
> > > On Mon, May 04, 2009 at 11:15:23AM +0200, Manuel Lauss wrote:
> > > > Hello!
> > > > 
> > > > Current -git (and a few revisions before that) oops when kernel tries to
> > > > mount nfsroot.  Anyone else seeing this?  (system is SH7760; I disabled
> > > > almost all of my platform code to rule out a screwup on my part. The code
> > > > works on 2.6.29).
> > > 
> > > Gaah, found it:  CONFIG_4KSTACKS=y is the culprit.  Removing it gives me a
> > > nicely working system again.
> > > 
> > > Sorry for the noise!
> > > 
> > That is interesting, I run with 4k stacks all the time without incident
> > on most configurations, with ample space to spare. Have you tried turning
> > on stack usage reporting to see where it is all going?
> 
> There are no warnings regarding stack overflows, and all in-kernel stack
> users have plenty (>P%) stack space left.  
> 
> The _real_ culprit is actually CONFIG_IRQSTACKS=y; 4k stacks on its own is
> fine, but with irqstacks enabled the kernel blows up with random oopses as
> soon as it goes on to start the init process.
> 
It looks like there is still some stack corruption going on here, I will
have to debug it some more. I've added a depends on BROKEN for now so
this doesn't get accidentally selected.
