From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 26 Oct 2009 22:49:40 +0000
Subject: Re: [PATCH] sh: Annotate irq functions with "notrace"
Message-Id: <20091026224940.GA2580@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1256595589-15800-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1256595589-15800-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 27, 2009 at 07:38:23AM +0900, Paul Mundt wrote:
> On Mon, Oct 26, 2009 at 10:19:49PM +0000, Matt Fleming wrote:
> > Now that SH's irqflags functions are out of line it becomes necessary to
> > mark them as "notrace" so that we don't try to trace them.
> > 
> > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> 
> This applies for the _64 bits too, but I just did those by hand.
> 
> Applied, thanks.

Ah, doh. I didn't realise that tracing worked for SUPERH64.
