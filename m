From: Kevin Hilman <khilman@ti.com>
Date: Fri, 08 Jul 2011 00:29:35 +0000
Subject: Re: [Update][PATCH 6/10] PM / Domains: System-wide transitions support for generic domains (v5)
Message-Id: <871uy1d380.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201106112223.04972.rjw@sisk.pl> <201106252324.13454.rjw@sisk.pl>
	<201106252328.31882.rjw@sisk.pl> <201106290144.01186.rjw@sisk.pl>
In-Reply-To: <201106290144.01186.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 29 Jun 2011 01:44:00 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Make generic PM domains support system-wide power transitions
> (system suspend and hibernation).  Add suspend, resume, freeze, thaw,
> poweroff and restore callbacks to be associated with struct
> generic_pm_domain objects and make pm_genpd_init() use them as
> appropriate.
>
> The new callbacks do nothing for devices belonging to power domains
> that were powered down at run time (before the transition).  

Thinking about this some more, how is a driver supposed to reconfigure
wakeups during suspend if it has already been runtime suspended?

For example, assume a device where device_may_wakeup() = false.  This
means wakeups during *suspend* are disabled, but wakeups wakeups are
assumed to enabled when it is runtime suspended.

So now, assume this device is RPM_SUSPENDED, it has wakeups *enabled*,
and then system suspend comes along.  

With this current patch, the driver will never receive any callbacks, so
it can never disable its wakeups.  

Am I missing something?

Kevin
