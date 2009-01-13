From: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
Date: Tue, 13 Jan 2009 00:58:25 +0000
Subject: Re: [Qemu-devel] sh: dcache flush breaks text region?
Message-Id: <20090113005825.GB30935@edgar.se.axis.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4968DD28.3030709@juno.dti.ne.jp>
	<20090110195332.GD26952@edgar.se.axis.com>
	<49696E54.9030102@juno.dti.ne.jp>
	<20090112125826.GA14489@linux-sh.org>
In-Reply-To: <20090112125826.GA14489@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>, qemu-devel@nongnu.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Mon, Jan 12, 2009 at 09:58:26PM +0900, Paul Mundt wrote:
> On Sun, Jan 11, 2009 at 12:58:12PM +0900, Shin-ichiro KAWASAKI wrote:
> > Edgar E. Iglesias wrote:
> > >One way to handle this particular cacheflush sequence might be to delay all
> > >movca stores until there's another load/store or cache control insn being
> > >issued to help you figure out if you can ignore previous movca. That will
> > >not by any means cover all cases though.
> > It seems a good way to avoid this problem.
> > My current modification plan is as follows.
> > - On executing 'movca', just record the store task which movca
> >   should do into CPUStatus.
> > - On executing 'ocbi', delete the store task.
> > - Let TCG produce 'delayed_movca' instruction for
> >   the first 'memory touching insn' or 'exception producing insn'
> >   after movca.
> > - On executing 'delayed_movca', do the store tasks. 
> > 
> There are other ways in which movca is used as well, including with
> ocbi/ocbwb (SH-X2 and later can also do ocbp), as well as with the movca
> line being operated on by mov later without any explicit manipulation of
> the dcache (common behaviour in read paths).

Yes but AFAICT the non ocbi cases are already kind of emulated (as good as
it gets without having cache models) both before and after the suggested
patch.

I think there might be a bit of confusion (maybe on my side). IIUC, the issue
is not really with the movca insn but more with the ocbi. Actually, I expect
any store immediately followed by ocbi to get canceled with the 7750
writeback cache policies (assuming no exceptions break the sequence). The
reason for using movca instead of mov when flushing the chaches is only to
avoid the unnecessary line fetch in case the mov misses.

The tricky part for QEMU to emulate is the ocbi in writeback mode because it
means we suddenly might need to ignore previous stores. Luckily most of the
ocbi use-cases are not realistic (many even give unpredictable results) and
can IMO be left as unsupported features of QEMU. AFAICT, only the
movca + ocbi cache flush+invalidate sequences have important use-cases that
are currently not handled by QEMU. I don't really want to advocate for a
change or not, but if the sh folks think it's important to handle that
particular sequence it might be possible with something along the lines with
Shin-ichiro's patch.

> If you are going to model it in CPUStatus, you are going to have to
> effectively have something that spans the size of the cache and watch out
> for accessors. Not all will be through the dcache modifier instructions,
> remember that memory-mapped access is also used for flushing in other
> areas.

If I understand the docs correctly the cache will always writeback dirty
entries when beeing invalidated in this manner, I think QEMU can ignore these
because everything is already in memory by then.

This led me to think of another issue, the cacheability bit in the tlb
entries. But why would sw do a movca + ocbi to an uncached address?
Can probably be ignored, but the suggested patch will incorrectly cancel
those stores.

> > >Another solution might be for linux to use a ocpb followed by a ocpi insn
> > >on the line. IIUC that should achieve the same results net results.
> > I'm not sure about it.  But I think we should not modify linux,
> > because now I guess that the current linux works on real silicon. 
> > 
> Yes, we do not want to modify linux for this. Implementing real caches in
> qemu is not going to be easy, but the kernel at least does have a
> CONFIG_CACHE_OFF which you can select for qemu. If there is a page we can
> test somewhere to figure out if we are under emulation we can likewise
> just turn them off directly at boot.

Does testing if atomic movca+ocbi stores leak to memory count? :)
No but what if qemu would hardwire the cache enable bits when reading
CCR to always be zero?

> Note that qemu also needs to be aware of the movca behavioural
> differences between cache enabled and disabled.

Good point. Caches in writethrough mode should maybe also be considered.

Sorry for the long reply...
Cheers
