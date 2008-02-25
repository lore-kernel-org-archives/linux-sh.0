From: Paul Mundt <paul.mundt@renesas.com>
Date: Mon, 25 Feb 2008 05:33:13 +0000
Subject: Re: [PATCH] maple: fix device detection
Message-Id: <20080225053313.GA27064@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1203863423.6474.27.camel@localhost.localdomain> <1203889834.6474.35.camel@localhost.localdomain> <1203892373.6299.2.camel@localhost.localdomain>
In-Reply-To: <1203892373.6299.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Sun, Feb 24, 2008 at 10:32:53PM +0000, Adrian McMenamin wrote:
> On Sun, 2008-02-24 at 21:50 +0000, Adrian McMenamin wrote:
> > On Sun, 2008-02-24 at 14:30 +0000, Adrian McMenamin wrote:
> > > The maple bus driver that went into the kernel mainline in
> > > September 2007 contained some bugs which were revealed by the
> > > update of the kobj code for the current release series.
> > > Unfortunately those bugs also helped ensure maple devices were
> > > properly detected. This patch (against the current git) now ensures
> > > that devices are properly detected again.
> > > 
> > 
> > Further testing has shown this has introduced another bug, this time
> > limiting the effectiveness of subdevice detection. Please ignore this
> > while I work on a fix.
> > 
> Sorry for the confusion, in fact there is nothing wrong with this code
> (ie it should be applied), the error was in the driver for the Dreamcast
> controller (the device, in general, into which the subdevices are
> plugged in and out).
> 
> I will post a fix for that.
> 
> Sorry again.
> 
So what exactly is supposed to be applied here?
