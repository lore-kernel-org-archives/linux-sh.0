From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 30 Jun 2011 23:25:25 +0000
Subject: Re: [PATCH 7/10 v6] PM / Domains: Don't stop wakeup devices during system sleep transitions
Message-Id: <201107010125.25875.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201106112223.04972.rjw@sisk.pl> <878vsjdjpx.fsf@ti.com> <201107010055.26952.rjw@sisk.pl>
In-Reply-To: <201107010055.26952.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kevin Hilman <khilman@ti.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

On Friday, July 01, 2011, Rafael J. Wysocki wrote:
> On Friday, July 01, 2011, Kevin Hilman wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
...
> > The decision of whether or not to clock gate and/or power gate based on
> > wakeup capabilies has to be made somewhere (and in fact is already made
> > by existing code.)  But IMO, that decision should only be made where
> > wakeup capabilies are known, so that sensible decisions (for power
> > management) can be made.
> > 
> > Until there is a way in the generic code to distinguish between the
> > various ways a device can wakeup, this decision should be left up to the
> > code that knows how.
> 
> OK, so I suppose your suggestion is to drop the patch and let the
> .stop_device() and .power_off() PM domain callbacks to hand

That should have been "handle".

> that, is this correct?

Anyway, neither .stop_device(), nor .power_off() can make such decisions,
because they are used for both runtime PM and system suspend, so they shouldn't
do system suspend-specific checks.

So the only way forward I can see is to add a special PM domain callback,
say .active_wakeup(), that will return "true" if the device is to be left
active if wakeup-enabled.  So the check you don't like will become
something like:

if (device_may_wakeup(dev) && genpd->active_wakeup
    && genpd->active_wakeup(dev))
        return 0;

Would that be better?

Rafael
