From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 06 Jan 2016 11:40:23 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <20160106114023.GU6344@twins.programming.kicks-ass.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-32-git-send-email-mst@redhat.com>
 <20160105232735.GC238@brightrain.aerifal.cx>
 <20160106131321-mutt-send-email-mst@redhat.com>
In-Reply-To: <20160106131321-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Jan 06, 2016 at 01:19:44PM +0200, Michael S. Tsirkin wrote:
> On Tue, Jan 05, 2016 at 06:27:35PM -0500, Rich Felker wrote:
> > On Thu, Dec 31, 2015 at 09:09:47PM +0200, Michael S. Tsirkin wrote:
> > > At the moment, xchg on sh only supports 4 and 1 byte values, so using it
> > > from smp_store_mb means attempts to store a 2 byte value using this
> > > macro fail.
> > > 
> > > And happens to be exactly what virtio drivers want to do.
> > > 
> > > Check size and fall back to a slower, but safe, WRITE_ONCE+smp_mb.
> > 
> > Can you please do this for size 1 as well (i.e. all sizes != 4)? If
> > you check the source, the code for size-1 xchg in sh cmpxchg-llsc.h is
> > completely wrong and operates on a 32-bit object at the address passed
> > to it. This code is presently unused anyway and I plan to submit a
> > patch to remove the size 1 case.
> > 
> > Rich
> 
> Ouch. And PeterZ says I should write a 2-byte xchg in asm instead,
> and Fedora can't even build a full kernel for this arch at the moment :(

Does the kernel.org hosted cross compiler work?

> Peter, what do you think? How about I leave this patch as is for now?

No, and I object to removing the single byte implementation too. Either
remove the full arch or fix xchg() to conform. xchg() should work on all
native word sizes, for SH that would be 1,2 and 4 bytes.
