From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 01 Jul 2011 14:45:02 +0000
Subject: Re: [PATCH 7/10 v6] PM / Domains: Don't stop wakeup devices during
Message-Id: <Pine.LNX.4.44L0.1107011043410.1988-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <201107010125.25875.rjw@sisk.pl>
References: <201106252329.24342.rjw@sisk.pl>
In-Reply-To: <201106252329.24342.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

On Fri, 1 Jul 2011, Rafael J. Wysocki wrote:

> So the only way forward I can see is to add a special PM domain callback,
> say .active_wakeup(), that will return "true" if the device is to be left
> active if wakeup-enabled.  So the check you don't like will become
> something like:
> 
> if (device_may_wakeup(dev) && genpd->active_wakeup
>     && genpd->active_wakeup(dev))
>         return 0;
> 
> Would that be better?

Another option, less flexible but perhaps easier to use, would be to 
set a couple of bitflags indicating whether the device needs power or 
clocks to handle wakeup signals.

Alan Stern

