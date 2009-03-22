From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 22 Mar 2009 15:43:00 +0000
Subject: Re: Kernel fails on Dreamcast - results of bisection
Message-Id: <20090322154300.GB16675@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1237675045.27611.23.camel@localhost.localdomain>
In-Reply-To: <1237675045.27611.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 22, 2009 at 01:49:46PM +0000, Adrian McMenamin wrote:
> On Sun, 2009-03-22 at 20:13 +0900, Paul Mundt wrote:
> > On Sat, Mar 21, 2009 at 11:39:25PM +0000, Adrian McMenamin wrote:
> > > (I am now getting a lot of messages about failures of the udev script -
> > > possibly because I have just turned a lot of debugging stuff on - in any
> > > case the system does boot and works with that commit reverted).
> > > 
> > These messages are about allocation failures, the exact same thing that
> > leads to your OOM. (It does help to actually read the error messages
> > rather than dismiss them as superfluous). While it is possible that the
> > timer patch pushed you over the edge on memory allocation, nothing else
> > suggests that you have pinpointed the real problem. Obviously udev did
> > not used to hit allocation failures, and we need to know when that
> > started, or what you did to your environment that causes it.
> > --
> 
> Could you explain what you mean by "These messages are about allocation
> failures, the exact same thing that leads to your OOM."
> 
It seems pretty self evident. If a virtual filesystem is returning
allocation failures, you have a problem, and you need to figure out why
you are getting those allocation failures from udev. The timer patch
might cause enough pressure that it makes the problem manifest in an oops
more readily, but your system is completely broken or without the timer
patch if you can't allocate pages to create device nodes, period.

> Isn't one a failure to allocate space on a block device and the other
> running out of memory, or have I missed something?
> 
What do you think the backing store for udev is?
