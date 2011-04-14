From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Apr 2011 18:20:42 +0000
Subject: Re: [RFC][PATCH] PM: Make power domain callbacks take precedence over
Message-Id: <BANLkTimQ6kX41-53Dw2RqEVyYzbT2qbz9Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201104130205.26988.rjw@sisk.pl>
In-Reply-To: <201104130205.26988.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@ti.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Len Brown <lenb@kernel.org>, linux-sh@vger.kernel.org, lethal@linux-sh.org, Alan Stern <stern@rowland.harvard.edu>

Hi Rafael,

On Wed, Apr 13, 2011 at 9:05 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Change the PM core's behavior related to power domains in such a way
> that, if a power domain is defined for a given device, its callbacks
> will be executed instead of and not in addition to the device
> subsystem's PM callbacks.

Thanks for your work on this! I'm very happy to see a more fine
grained interface for SoC specific code compared to the weak symbols
and other coarse grained alternatives for the platform bus.

My only thought on this is if we really want to limit ourselves to
only control power domains using these callbacks. I can imagine that
some SoCs want to do other non-power domain specific operations with
these callbacks, and if so, perhaps using the term power domain as
name of the pointer in struct device would be somewhat odd. OTOH, I
really dislike naming discussions in general and I can't really think
of any good names. So it all looks more like a set of system specific
PM override hooks.

Or is there something that is really power domain specific with these hooks?

Thanks,

/ magnus
