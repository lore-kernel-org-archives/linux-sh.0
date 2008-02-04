From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 04 Feb 2008 23:09:20 +0000
Subject: Re: [PATCH] SH/Dreamcast - fix regressions, whitespace and memory
Message-Id: <1202166560.7046.15.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1202068847.6262.7.camel@localhost.localdomain>
	 <20080204052900.GB7585@kroah.com>
	 <1202113675.6489.6.camel@localhost.localdomain>
	 <20080204161437.GA20739@kroah.com>
	 <1202164657.7046.5.camel@localhost.localdomain>
In-Reply-To: <1202164657.7046.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


On Mon, 2008-02-04 at 22:37 +0000, Adrian McMenamin wrote:

> 
> The hardware is very flaky. If I add in delays to the bus start, it will
> detect the devices, but it's not brilliant. Registering an empty device
> got round that problem, at the price of testing for the earlier
> registration.
> 


I have found if I push it (and drivers) further down the initcall
hierarchy that problem is less significant and the hardware seems to be
properly detected.

I'll look to post a clean up series of patches in the next few days.

