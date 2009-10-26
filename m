From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Oct 2009 22:57:34 +0000
Subject: Re: [PATCH] sh: Annotate irq functions with "notrace"
Message-Id: <20091026225734.GC16759@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1256595589-15800-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1256595589-15800-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 26, 2009 at 10:49:40PM +0000, Matt Fleming wrote:
> On Tue, Oct 27, 2009 at 07:38:23AM +0900, Paul Mundt wrote:
> > On Mon, Oct 26, 2009 at 10:19:49PM +0000, Matt Fleming wrote:
> > > Now that SH's irqflags functions are out of line it becomes necessary to
> > > mark them as "notrace" so that we don't try to trace them.
> > > 
> > > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> > 
> > This applies for the _64 bits too, but I just did those by hand.
> > 
> > Applied, thanks.
> 
> Ah, doh. I didn't realise that tracing worked for SUPERH64.

It doesn't yet, but we like to do future proofing, especially when the
issue at hand is fresh in ones mind. Otherwise we run in to situations
where when a feature is finally carried over, all of the subtle fixes
that came along with it are long forgotten and much debugging ensues.

Also note that notrace in itself has more implications than simply
tracing, it explicitly disables instrumentation. So it also matters
in the mcount case. If it were only the function graph tracer that were
problematic (as in the case of __switch_to) we would use __notrace_funcgraph,
which is much more explicitly stated.
