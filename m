From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 09 Feb 2009 21:41:56 +0000
Subject: Re: [PATCH] sh: maple: add support for Visual Memory Card devices,
Message-Id: <1234215716.6756.18.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1234122069.6736.8.camel@localhost.localdomain>
	 <20090209065632.GA21980@linux-sh.org>
	 <1234207053.6756.11.camel@localhost.localdomain>
	 <200902091433.57126.vapier@gentoo.org>
In-Reply-To: <200902091433.57126.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Mon, 2009-02-09 at 14:33 -0500, Mike Frysinger wrote:

> 
> then you'd end up with 4 clearly marked files (assuming your log message for 
> each change is clear).  in the summary, you should then make statements like:
> Patch 1 (... subject ...) in this series can be applied by itself for the bus 
> driver.  Then patch 2 (... subject ...) and 3 (... subject ...) can be applied 
> as they need the bus changes.
> -mike


Fair enough.

I ought to resubmit patches anyway because previous code has a memory
leak/race which I've now fixed with a couple of extra lines.

But the basic point here is that changing the bus code is necessary to
get the VMU driver (or *any* VMU driver) to work, but changing the bus
driver also breaks the two existing drivers in mainline that use the
bus. The breakage in terms of lines to be fixed is small, but it still
needs to be done 'all at once'.

