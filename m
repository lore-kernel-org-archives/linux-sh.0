From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Sep 2009 08:17:56 +0000
Subject: Re: [PATCH] sh: Don't enable interrupts in the page fault path
Message-Id: <20090928081756.GA7678@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1253994245-3739-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1253994245-3739-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Sep 26, 2009 at 08:44:05PM +0100, Matt Fleming wrote:
> There's already code in do_page_fault() to conditionally enable
> interrupts, so we don't need to unconditonally enable them before
> calling it. This fixes a lockdep warning where we called
> trace_hardirqs_off() but with irqs still enabled.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

This is a relic from the days where do_page_fault() did not do the
conditional re-enabling. Applied, thanks.
