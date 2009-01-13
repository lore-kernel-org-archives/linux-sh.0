From: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
Date: Tue, 13 Jan 2009 02:57:22 +0000
Subject: Re: [Qemu-devel] sh: dcache flush breaks text region?
Message-Id: <20090113025722.GC30935@edgar.se.axis.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4968DD28.3030709@juno.dti.ne.jp>
	<20090110195332.GD26952@edgar.se.axis.com>
	<49696E54.9030102@juno.dti.ne.jp>
	<20090111104259.GE26952@edgar.se.axis.com>
In-Reply-To: <20090111104259.GE26952@edgar.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Edgar E. Iglesias" <edgar@axis.com>
Cc: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>, qemu-devel@nongnu.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Sun, Jan 11, 2009 at 11:42:59AM +0100, Edgar E. Iglesias wrote:
> On Sun, Jan 11, 2009 at 12:58:12PM +0900, Shin-ichiro KAWASAKI wrote:
> >
> > Edgar E. Iglesias wrote:
> >> Another solution might be for linux to use a ocpb followed by a ocpi insn
> >> on the line. IIUC that should achieve the same results net results.
> > I'm not sure about it.  But I think we should not modify linux,
> 
> I agree.
> 
> The ocpb followed by the ocpi that I suggested won't work and I cant
> think of anything better than what linux is already doing.

I gave this some more thought and I think that there might be room for
improvements in the cache-sh4 flushing loops anyway.

The reason why the suggested ocbp+ocbi sequences didn't work was because
I later noticed that the same loop was beeing used for unconditional line
flushes aswell as for flushes for ranges where you actually know the
virtual addresses you want to flush (complete page flushes seem to be
treated differently).

If you separate the two, the flushes for virtual ranges can be done with
the ocbp+ocbi sequence. If I'm not misstaken, there are two main
advantages:

1. You will flush and invalidate much fewer lines, only those that
   actually hit in the cache. This could turn out to be a pretty
   significant win.
2. You get rid of the atomic requirements. It means you can do all the
   ranged flushes with interrupts enabled all the time.

Best regards
