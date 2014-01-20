From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 20 Jan 2014 12:01:00 +0000
Subject: Re: [PATCH] ARM: shmobile: compile drivers/sh for CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <52DD0FFC.8020307@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389367095-7760-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389367095-7760-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 20/01/14 11:47, Mark Brown wrote:
> On Sun, Jan 19, 2014 at 10:44:53PM +0100, Laurent Pinchart wrote:
>> On Thursday 16 January 2014 17:25:09 Ben Dooks wrote:
>
>>> I was having a think, and how about adding the following to each
>>> driver that expects clock management to happen for it, such as the
>>> following in the probe sequence:
>
>>> 	pm_runtime_manage_clock(dev);
>
>>> This would mean the following:
>
>>> - People would know a driver had its clock managed elsewhere
>>> - You couldn't build a system with the clock_ops disabled.
>>> - A system where a mix of drivers where used would work fine
>>> - drivers/sh/pm_runtime.c could be deleted too.
>
>> That sounds like a good idea to me. I like how drivers will be responsible for
>> explicitly delegating clock handling to generic code. This combines simplicity
>> with flexibility, and doesn't hide clock handling.
>
>> Mark, Rafael, any opinion ?
>
> I think that just makes things more complicated and isn't adding
> anything over pm_runtime_enable(), it's just boilerplate code.  In
> theory essentially every driver running on platforms which don't have
> explicit management of core IP clocks ought to be calling this since
> potentially the IP might be deployed on another platform which does have
> clock management (this does actually happen with things like the
> DesignWare IPs) and it doesn't do anything like say which clocks are
> expected to be managed in this way which is another thing that can come
> up when moving devices between platforms.

That sounds like a real headache where you have two sets of code
looking at possibly the same clocks, and behaving differently between
different platforms.

> I'm also struggling to see how it provides any sort of build time
> protection, it would allow the generation of a warning at runtime at
> best.

If you don't have the code it WILL NOT LINK. At the moment it is
entirely possible to link a kernel which will produce a set of confusing
errors as drivers fail to initialise at startup.

We've already had other people run into the issue where they do not
know why a driver is failing to work (rcar-thermal is one) as the code
that was managing the clock for it magically vanished during the
development cycle.

> As far as I can tell the problem that Ben has seen here is that the
> platform really, really needs the code for its power domains running to
> be functional (this doesn't seem unreasonable and may not be related to
> clocks, this may be required to have the IPs powered up at all).  I'd
> expect this is something for the platform to sort out rather than
> something for individual drivers to have to carry code for.

What's power domains got to do with this? You keep bringing this up
but the error is purely to do with clock management. The code happens
to be sitting in the drivers/base/pm directory, but could easily sit
elsewhere.

> If it was going to be drivers carrying code for this I would expect it
> to be something like providing a list of clocks to be managed along with
> runtime PM - this would also make the code more widely applicable since
> it's quite common for the runtime PM callbacks to do nothing more than
> just enable and disable clocks.

If we are really saying that bus clocks should not be managed
by the drivers, then we should just enable this across the whole
kernel and remove the management from any extant drivers (or make
it so that any drivers that must manage their bus clocks have a
call to do so).

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
