From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 24 May 2012 10:28:29 +0000
Subject: Re: [PATCH 01/03] clockevents: Make clockevents_config() a global symbol
Message-Id: <alpine.LFD.2.02.1205241227470.3231@ionos>
List-Id: <linux-sh.vger.kernel.org>
References: <20120509143926.27521.20342.sendpatchset@w520> <20120509143934.27521.46553.sendpatchset@w520> <20120523063218.GB11860@linux-sh.org> <alpine.LFD.2.02.1205241225580.3231@ionos>
In-Reply-To: <alpine.LFD.2.02.1205241225580.3231@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, horms@verge.net.au, linux-sh@vger.kernel.org, johnstul@us.ibm.com, rjw@sisk.pl, gregkh@linuxfoundation.org, olof@lixom.net

On Thu, 24 May 2012, Thomas Gleixner wrote:

> On Wed, 23 May 2012, Paul Mundt wrote:
> 
> > On Wed, May 09, 2012 at 11:39:34PM +0900, Magnus Damm wrote:
> > > From: Magnus Damm <damm@opensource.se>
> > > 
> > > Make clockevents_config() into a global symbol to allow it
> > > to be used by compiled-in clockevent drivers. This is needed
> > > by drivers that want to update the timer frequency after
> > > registration time.
> > > 
> > > Signed-off-by: Magnus Damm <damm@opensource.se>
> > 
> > Any update on this?
> 
> Ooops, I missed that. Can you take it through your tree with my
> acked-by please?

Gah crap. I take the whole lot. Didn't notice that the driver is in
drivers/clocksource.

Sorry for the confusion.
