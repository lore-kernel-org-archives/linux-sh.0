From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 23 Jun 2011 14:19:59 +0000
Subject: Re: [Update][PATCH 7/8] PM / Domains: System-wide transitions support
Message-Id: <Pine.LNX.4.44L0.1106231016580.2033-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <201106230016.46704.rjw@sisk.pl>
References: <201106120128.04271.rjw@sisk.pl>
In-Reply-To: <201106120128.04271.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

On Thu, 23 Jun 2011, Rafael J. Wysocki wrote:

> Well, let's say this part of the documentation is slightly outdated.
> 
> It basically refers to the model in which system suspend is a separate global
> hardware or firmware operation, so the state of devices may be changed by the
> BIOS or whatever takes over control in the meantime.  In that case the kernel
> has to ensure that the states of devices are consistent with what it thinks
> about them and the simplest way to achieve that is to put the devices to
> full power during resume (and back to low power if that's desirable).
> 
> However, in the case of the systems this patchset is intended for system
> suspend is achieved by putting various hardware components into low-power
> states directly in a coordinated way and the system sleep state effectively
> follows from the low-power states the hardware components end up in.  The
> system is woken up from this state by an interrupt or another mechanism under
> the kernel's control.  As a result, the kernel never gives control away, so
> the state of devices after the resume is precisely known to it.
> In consequence, it need not ensure that the state of devices is consistent with
> its view, because it knows that this is the case. :-)

That's true for system suspend, but it's probably not true for
hibernation, even in embedded systems.  Of course, many embedded
systems don't use hibernation at all -- but those that do should be
aware of this issue.

> So the documentation should be updated to say what hardware model it is
> referring to.

It might be worthwhile to include a little warning about the difference 
between suspend and hibernate.

Alan Stern

