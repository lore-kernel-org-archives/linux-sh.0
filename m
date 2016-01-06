From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 06 Jan 2016 11:19:44 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <20160106131321-mutt-send-email-mst@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-32-git-send-email-mst@redhat.com>
 <20160105232735.GC238@brightrain.aerifal.cx>
In-Reply-To: <20160105232735.GC238@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org

On Tue, Jan 05, 2016 at 06:27:35PM -0500, Rich Felker wrote:
> On Thu, Dec 31, 2015 at 09:09:47PM +0200, Michael S. Tsirkin wrote:
> > At the moment, xchg on sh only supports 4 and 1 byte values, so using it
> > from smp_store_mb means attempts to store a 2 byte value using this
> > macro fail.
> > 
> > And happens to be exactly what virtio drivers want to do.
> > 
> > Check size and fall back to a slower, but safe, WRITE_ONCE+smp_mb.
> 
> Can you please do this for size 1 as well (i.e. all sizes != 4)? If
> you check the source, the code for size-1 xchg in sh cmpxchg-llsc.h is
> completely wrong and operates on a 32-bit object at the address passed
> to it. This code is presently unused anyway and I plan to submit a
> patch to remove the size 1 case.
> 
> Rich

Ouch. And PeterZ says I should write a 2-byte xchg in asm instead,
and Fedora can't even build a full kernel for this arch at the moment :(

Peter, what do you think? How about I leave this patch as is for now?

-- 
MST
