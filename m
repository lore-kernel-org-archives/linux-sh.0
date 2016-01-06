From: Rich Felker <dalias@libc.org>
Date: Wed, 06 Jan 2016 18:23:50 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <20160106182349.GD238@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-32-git-send-email-mst@redhat.com>
 <20160105232735.GC238@brightrain.aerifal.cx>
 <20160106131321-mutt-send-email-mst@redhat.com>
 <20160106114023.GU6344@twins.programming.kicks-ass.net>
 <20160106134301-mutt-send-email-mst@redhat.com>
 <20160106143218.GV6344@twins.programming.kicks-ass.net>
In-Reply-To: <20160106143218.GV6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Landley <rob@landley.net>, Jeff Dionne <jeff@uclinux.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Wed, Jan 06, 2016 at 03:32:18PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 06, 2016 at 01:52:17PM +0200, Michael S. Tsirkin wrote:
> > > > Peter, what do you think? How about I leave this patch as is for now?
> > > 
> > > No, and I object to removing the single byte implementation too. Either
> > > remove the full arch or fix xchg() to conform. xchg() should work on all
> > > native word sizes, for SH that would be 1,2 and 4 bytes.
> > 
> > Rick, maybe you could explain how is current 1 byte xchg on llsc wrong?
> 
> It doesn't seem to preserve the 3 other bytes in the word.
> 
> > It does use 4 byte accesses but IIUC that is all that exists on
> > this architecture.
> 
> Right, that's not a problem, look at arch/alpha/include/asm/xchg.h for
> example. A store to another portion of the word should make the
> store-conditional fail and we'll retry the loop.
> 
> The short versions should however preserve the other bytes in the word.

Indeed. Also, accesses must be aligned, so the asm needs to round down
to an aligned address and perform a correct read-modify-write on it,
placing the new byte in the correct offset in the word.

Alternatively (my preference) this logic can be impemented in C as a
wrapper around the 32-bit cmpxchg. I think this is less error-prone
and it can be shared between the multiple sh cmpxchg back-ends,
including the new cas.l one we need for J2.

> SH's cmpxchg() is equally incomplete and does not provide 1 and 2 byte
> versions.
> 
> In any case, I'm all for rm -rf arch/sh/, one less arch to worry about
> is always good, but ISTR some people wanting to resurrect SH:
> 
>   http://old.lwn.net/Articles/647636/
> 
> Rob, Jeff, Sato-san, might I suggest you send a MAINTAINERS patch and
> take up an active interest in SH lest someone 'accidentally' nukes it?

We're in the process of preparing such a proposal right now. That
current intent is that Sato-san and I will co-maintain arch/sh. We'll
include more details about motivation, proposed development direction,
existing work to be merged, etc. in that proposal.

Rich
