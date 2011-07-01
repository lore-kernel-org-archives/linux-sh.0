From: Kevin Hilman <khilman@ti.com>
Date: Fri, 01 Jul 2011 18:27:22 +0000
Subject: Re: [PATCH 0/10 v6] PM / Domains: Support for generic I/O PM domains
Message-Id: <87fwmpyhyt.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201106112223.04972.rjw@sisk.pl> <201106252324.13454.rjw@sisk.pl>
In-Reply-To: <201106252324.13454.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 25 Jun 2011 23:24:13 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Hi,
>
> Well, one more update. :-)
>
> This is the 6th version of the patchset adding support for generic I/O PM
> domains.  The majority of patches have had some small fixes here and there
> to make things work when CONFIG_PM_RUNTIME is unset.  In addition to that,
> to make the shmobile code introduced by the last patch work for
> CONFIG_PM_RUNTIME unset I had to add patches [8-9/10].  Patch [7/10]
> adds wakeup support that was missing from the previous version and I
> decided not to push patch [1/10] for 3.0 after all.

For everything but the shmobile specifics, which I didn't look at too
closely, and the changes for [7/10] that we agreed on:

Reviewed-by: Kevin Hilman <khilman@ti.com>

Thanks!

Kevin
