From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 16 May 2011 18:26:26 +0000
Subject: Re: [PATCH 8/9] OMAP1 / PM: Use generic clock manipulation routines for runtime PM
Message-Id: <201105162026.27009.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201104130205.26988.rjw@sisk.pl> <201104242343.41456.rjw@sisk.pl> <87mxindk7m.fsf@ti.com>
In-Reply-To: <87mxindk7m.fsf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kevin Hilman <khilman@ti.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Len Brown <lenb@kernel.org>, linux-sh@vger.kernel.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@suse.de>

On Monday, May 16, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Convert OMAP1 to using the new generic clock manipulation routines
> > and a device power domain for runtime PM instead of overriding the
> > platform bus type's runtime PM callbacks.  This allows us to simplify
> > OMAP1-specific code and to share some code with other platforms
> > (shmobile in particular).
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Thanks!
