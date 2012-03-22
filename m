From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 22 Mar 2012 03:25:12 +0000
Subject: Re: Single-stepping with UBC on SH7785
Message-Id: <20120322032511.GE26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjidcrrn.fsf@schwinge.name>
In-Reply-To: <87sjidcrrn.fsf@schwinge.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 01, 2012 at 04:50:46PM +0100, Thomas Schwinge wrote:
> On Fri, 24 Feb 2012 14:36:47 +0900, Paul Mundt <lethal@linux-sh.org> wrote:
> > That would be because we're using it differently. It was originally
> > reworked in order to permit use of multiple UBC channels, and geared at
> > the ksym tracer (subsequently superseded by generic perf hw_breakpoint
> > API utilization). The intent was the model the same single-step behaviour
> > as previously over top of the new API, but there are some caveats (ie,
> > perf can have all of the available channels locked down, making
> > set_single_step() fail).
> 
> The interface of user_enable_single_step assumes it cannot fail.  But in
> there, set_single_step may in fact fail (as I understand it), but its
> return value is currently ignored.  What should happen in this case?
> Patch a breakpoint instruction into the code instead of using the UBC for
> single stepping?
> 
That's one option, yes. For starters it would also be worthwhile teaching
ptrace_resume() about user_enable_single_step() failures for pushing up
an the set_single_step() errno value.

> In set_single_step, currently only ptrace_bps[0] is considered for use --
> which is not a problem for the moment, as single stepping is the only
> user.
> 
Yes, this really should be fixed, too.

> > The reserved bit is functionally immaterial. It's always wired to 1, so
> > it makes no difference what is read/written to it. We can add a 1 write
> > to it to line up with the manual if you like, but in general the UBC
> > chapter has been cut-and-pasted from legacy parts for years, to the
> > extent that the manual should really only be considered a loose guideline
> > (for some CPUs the register map is nowhere near where the manual
> > suggests, for example). Your CRR_INIT value is just setting CRR_RES
> > anyways.
> 
> Huh, OK...  For me, the manual is the only reference I have.  (For
> example, the manual says to always write reserved bits as they are
> read/defined.)  This is why first worked a lot on aligning the
> implementation with the manual.  Please tell which other documentation
> should I be looking at?
> 
There isn't much I'm afraid. I also generally only have the manual to go
with. The problem however is that the manual for the most part is either
woefully out of date or just completely inaccurate. It's a loose
reference, nothing more.

> > I left the ASID stuff out initially to keep things simple (SH-X3 cores
> > and later all have extended ASIDs, so we have an extra set of CBR
> > registers to program for extended ASID matching -- this applies to
> > anything with PTEAEX capabilities). We obviously don't require it on the
> > kernel side, but you're right that we should add it back in for the
> > userspace case. If you want to hack up some patches for that I'll
> > certainly use them, otherwise I'll see about hacking something up for you
> > to test.
> 
> I will have to learn more about ASIDs.  Is the manual the correct
> document to read?
> 
Yes. Note that we're using PTEAEX unconditionally on parts that support
it, so that will need to be taken in to account, too. I can take care of
that part though if you're hacking something simple up for the easier
parts.

> > It wasn't entirely obvious from your mail, but is the general conclusion
> > from all this that with the clock properly registered for SH7785 that
> > single-stepping works as you expected it to?
> 
> That is correct.  For convenience, I'm again attaching the patch here --
> please push that one for the moment.
> 
I forgot to reply to your patch earlier, but Linus already merged it for
3.3-final.
