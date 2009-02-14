From: Greg KH <greg@kroah.com>
Date: Sat, 14 Feb 2009 21:59:19 +0000
Subject: Re: [PATCH] sh: maple: Update the maple bus driver to support
Message-Id: <20090214215919.GA24052@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1234641948.6609.13.camel@localhost.localdomain>
In-Reply-To: <1234641948.6609.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@users.sourceforge.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sat, Feb 14, 2009 at 08:05:48PM +0000, Adrian McMenamin wrote:
> Greg,
> 
> This patch updates the maple bus to support asynchronous block reads and
> writes as well as generally improving the quality of the code and
> supporting concurrency (all needed to support the Dreamcast visual
> memory unit - a driver will also be posted for that).
> 
> I have posted versions of this before but am here following the patch
> grouping suggested and have also tested this code and unlike earlier
> versions it shows no signs of suffering from race conditions - so I hope
> you will be happy to queue it for inclusion.

Looks good to me, but shouldn't this go through the sh maintainers
instead?  This is their area, right?

thanks,

greg k-h
