From: Greg KH <gregkh@suse.de>
Date: Sat, 30 Apr 2011 01:08:18 +0000
Subject: Re: [Update][RFC][PATCH 1/2] PM / Runtime: Support for generic I/O
Message-Id: <20110430010818.GA32601@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201104290154.12966.rjw@sisk.pl>
 <201104290154.56145.rjw@sisk.pl>
 <201104300254.46973.rjw@sisk.pl>
In-Reply-To: <201104300254.46973.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Sat, Apr 30, 2011 at 02:54:46AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introcude common headers, helper functions and callbacks allowing
> platforms to use simple generic power domains for runtime power
> management.
> 
> Introduce struct generic_power_domain to be used for representing
> power domains that each contain a number of devices and may be
> master domains or subdomains with respect to other power domains.
> Among other things, this structure includes callbacks to be
> provided by platforms for performing specific tasks related to
> power management (i.e. ->stop_device() may disable a device's
> clocks, while ->start_device() may enable them, ->power_on() is
> supposed to remove power from the entire power domain
> and ->power_off() is supposed to restore it).
> 
> Introduce functions that can be used as power domain runtime PM
> callbacks, pm_genpd_runtime_suspend() and pm_genpd_runtime_resume(),
> as well as helper functions for the initialization of a power
> domain represented by a struct generic_power_domain object,
> adding a device to or removing a device from it and adding or
> removing subdomains.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> 
> Hi,
> 
> This version of the patch fixes a bug that caused pm_runtime_suspend()
> (and equivalent) to return -EBUSY erroneously when suspending the last
> active device in a power domain.  It has been tested on an ARM shmobile
> system.
> 
> Greg, I hope your ACK is still valid. :-)

Yes, it is.

