From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 27 Dec 2010 01:36:49 +0000
Subject: Re: SDHI polling
Message-Id: <20101227013649.GC16946@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101226224506.GD21535@verge.net.au>
In-Reply-To: <20101226224506.GD21535@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 27, 2010 at 10:03:06AM +0900, Magnus Damm wrote:
> On Mon, Dec 27, 2010 at 9:10 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> > In any event, just because the boot loader people are useless doesn't
> > mean you can't set the bar a bit higher for yourself when designing new
> > features.
> 
> Sure, but I don't think that raising the bar by implementing interrupt
> support is a good idea in this case. This since all you're doing is
> loading a kernel image from a single device.
> 
I agree that things should be kept as simple as possible, we basically
want as few variables that can lead to failure as possible at that stage.
If this can be accomplished without having to model some sort of an
asynchronous state machine, then of course that's the most
straightforward.

The entire point after all is to get away from this sort of boot loader
ineptitude, so we don't really want to recreate a boot loader within the
image loading stubs as a replacement.

I don't know enough about how SDHI works to have any strong opinions on
the matter one way or the other, but one does need to keep in mind that
cards will degrade over time and will need to have recoverable errors
handled for any sort of real-world application, whether this is something
we will invariably have to install an exception handler for or not I
don't know. Ideally if there is some retry logic in the mask ROM then
this all gets much simpler.
