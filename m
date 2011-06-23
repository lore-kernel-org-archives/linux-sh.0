From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 23 Jun 2011 14:44:50 +0000
Subject: Re: [Update][PATCH 7/8] PM / Domains: System-wide transitions support for generic domains (v3)
Message-Id: <201106231644.50965.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.44L0.1106231016580.2033-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1106231016580.2033-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

On Thursday, June 23, 2011, Alan Stern wrote:
> On Thu, 23 Jun 2011, Rafael J. Wysocki wrote:
> 
> > Well, let's say this part of the documentation is slightly outdated.
> > 
> > It basically refers to the model in which system suspend is a separate global
> > hardware or firmware operation, so the state of devices may be changed by the
> > BIOS or whatever takes over control in the meantime.  In that case the kernel
> > has to ensure that the states of devices are consistent with what it thinks
> > about them and the simplest way to achieve that is to put the devices to
> > full power during resume (and back to low power if that's desirable).
> > 
> > However, in the case of the systems this patchset is intended for system
> > suspend is achieved by putting various hardware components into low-power
> > states directly in a coordinated way and the system sleep state effectively
> > follows from the low-power states the hardware components end up in.  The
> > system is woken up from this state by an interrupt or another mechanism under
> > the kernel's control.  As a result, the kernel never gives control away, so
> > the state of devices after the resume is precisely known to it.
> > In consequence, it need not ensure that the state of devices is consistent with
> > its view, because it knows that this is the case. :-)
> 
> That's true for system suspend, but it's probably not true for
> hibernation, even in embedded systems.  Of course, many embedded
> systems don't use hibernation at all -- but those that do should be
> aware of this issue.
> 
> > So the documentation should be updated to say what hardware model it is
> > referring to.
> 
> It might be worthwhile to include a little warning about the difference 
> between suspend and hibernate.

Well, there already is one:

"* The driver's idea of the device state may not agree with the device's
    physical state.  This can happen during resume from hibernation."

(in Documentation/power/runtime_pm.txt).  Also, the new text in the patch
https://lkml.org/lkml/2011/6/23/200 I've just sent says literally:

"If that is the case and none of the situations listed above takes place, it
 may be more efficient to leave the devices that had been suspended before
 the system sleep began in the suspended state."

where the "situations listed above" include it.

Do you think that's not sufficient?

Rafael
