From: Kevin Hilman <khilman@ti.com>
Date: Mon, 16 May 2011 10:16:13 +0000
Subject: Re: [PATCH 8/9] OMAP1 / PM: Use generic clock manipulation routines for runtime PM
Message-Id: <87mxindk7m.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201104130205.26988.rjw@sisk.pl> <201104170135.19388.rjw@sisk.pl>
	<201104242330.13607.rjw@sisk.pl> <201104242343.41456.rjw@sisk.pl>
In-Reply-To: <201104242343.41456.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sun, 24 Apr 2011 23:43:41 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Len Brown <lenb@kernel.org>, linux-sh@vger.kernel.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@suse.de>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Convert OMAP1 to using the new generic clock manipulation routines
> and a device power domain for runtime PM instead of overriding the
> platform bus type's runtime PM callbacks.  This allows us to simplify
> OMAP1-specific code and to share some code with other platforms
> (shmobile in particular).
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Kevin Hilman <khilman@ti.com>

