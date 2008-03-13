From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Mar 2008 10:39:29 +0000
Subject: Re: Fixing up unaligned userspace access
Message-Id: <20080313103929.GA6935@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1204900215.12315.174.camel@atlas.mpc-data.co.uk>
In-Reply-To: <1204900215.12315.174.camel@atlas.mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 12, 2008 at 06:41:57PM +0000, Kieran Bingham wrote:
> On 07/03/2008, Adrian McMenamin <adrian@newgolddream.dyndns.info> wrote:
> > On Fri, March 7, 2008 2:30 pm, Kieran Bingham wrote:
> >  >
> >  > Fixing up unaligned userspace access in "sh" pidH pc=0x0ccda168
> >  > ins=0x60f0
> >  >
> >  > Fixing up unaligned userspace access in "sh" pidH pc=0x0ccd9eac
> >  > ins=0x9015
> >  > Mainly I'm confused though, as looking at the assembly the instructions
> >  > aren't unaligned ? and don't seem to be trying to do anything
> >  > un-aligned ? - Is there something else that could be going on here?
> 
> > My experience - admittedly with SH4 - is that these errors are almost
> >  always caused by a memory leak, or access to uninitialized memory, elsewhere
> >  in the kernel.
> 
> The instructions don't look like they perform anything bad, because they don't!
> 
> They are the wrong instructions. ... would seem that the address error
> trap handler is adding 4 to the regs pointer before it calls
> do_address_error, so regs->pc was actually returning the PR!!
> 
> Does anyone know why this code adds 4 ?
> Can we remove it if its incorrect (patch below)
> 
> I'm working on SH2a, so I don't know if its an SH2 specific thing
> thats been put in ?
> 
It's definitely not an SH-2 thing. I wonder if it's a left over remnant
from when we were placing markers on the stack in the early days of the
SH-2 port. Anyways, dumping the stack from the address error path makes
it pretty obvious that the add is forcing all of the state to be off by
one register, which also explains why the regs->sr check was failing.

Given that, I'll add your patch to the 2.6.25 queue. Though it seems like
there are still a few corruption issues outstanding, which the slab
caches in particular seem to hit. There's occasional garbage in regs->pc,
which suggests that the exceptions are nesting and we're hitting the case
where the saved PC value is undefined. I've been debugging this most of
the day, and found a number of other bugs in the nommu code, but most of
the corruption issues are still outstanding (using current git both on
the SH7203 RSK and the SH7206 SolutionEngine).
