From: Kevin Hilman <khilman@ti.com>
Date: Wed, 22 Jun 2011 21:50:51 +0000
Subject: Re: [Update][PATCH 7/8] PM / Domains: System-wide transitions support for generic domains (v3)
Message-Id: <8739j1lemc.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201106112223.04972.rjw@sisk.pl> <201106112239.16285.rjw@sisk.pl>
	<201106200006.07642.rjw@sisk.pl>
In-Reply-To: <201106200006.07642.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Mon, 20 Jun 2011 00:06:07 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

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

Great, this is the approach I prefer too, but...

Now I'm confused.  Leaving runtime suspended devices alone is what I was
doing in my subsystem but was told not to.  According to

    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50690.html

"it's generally agreed that _all_ devices should return to full 
power during system resume -- even if they were runtime suspended 
before the system sleep."

Kevin
