From: Kevin Hilman <khilman@ti.com>
Date: Mon, 20 Jun 2011 23:37:39 +0000
Subject: Re: [PATCH 2/8] PM / Domains: Rename struct dev_power_domain to struct dev_pm_domain
Message-Id: <87fwn45b24.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201106112223.04972.rjw@sisk.pl> <201106112226.07631.rjw@sisk.pl>
In-Reply-To: <201106112226.07631.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 11 Jun 2011 22:26:07 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> The naming convention used by commit 7538e3db6e015e890825fbd9f86599b
> (PM: Add support for device power domains), which introduced the
> struct dev_power_domain type for representing device power domains,
> evidently confuses some developers who tend to think that objects
> of this type must correspond to "power domains" as defined by
> hardware, which is not the case.  Namely, at the kernel level, a
> struct dev_power_domain object can represent arbitrary set of devices
> that are mutually dependent power management-wise and need not belong
> to one hardware power domain.  To avoid that confusion, rename struct
> dev_power_domain to struct dev_pm_domain and rename the related
> pointers in struct device and struct pm_clk_notifier_block from
> pwr_domain to pm_domain.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Kevin Hilman <khilman@ti.com>

Thanks!

Kevin
