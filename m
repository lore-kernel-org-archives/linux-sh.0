From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 Feb 2008 05:20:09 +0000
Subject: Re: [PATCH] maple: fix device detection
Message-Id: <20080226052009.GA19814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1203863423.6474.27.camel@localhost.localdomain> <1203889834.6474.35.camel@localhost.localdomain> <1203892373.6299.2.camel@localhost.localdomain> <20080225053313.GA27064@renesas.com> <1203925226.6364.4.camel@localhost.localdomain>
In-Reply-To: <1203925226.6364.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Mon, Feb 25, 2008 at 07:40:26AM +0000, Adrian McMenamin wrote:
> On Mon, 2008-02-25 at 14:33 +0900, Paul Mundt wrote:
> > On Sun, Feb 24, 2008 at 10:32:53PM +0000, Adrian McMenamin wrote:
> > > On Sun, 2008-02-24 at 21:50 +0000, Adrian McMenamin wrote:
> > > > On Sun, 2008-02-24 at 14:30 +0000, Adrian McMenamin wrote:
> > > > > The maple bus driver that went into the kernel mainline in
> > > > > September 2007 contained some bugs which were revealed by the
> > > > > update of the kobj code for the current release series.
> > > > > Unfortunately those bugs also helped ensure maple devices were
> > > > > properly detected. This patch (against the current git) now ensures
> > > > > that devices are properly detected again.
> > > > > 
> > > > 
> > > > Further testing has shown this has introduced another bug, this time
> > > > limiting the effectiveness of subdevice detection. Please ignore this
> > > > while I work on a fix.
> > > > 
> > > Sorry for the confusion, in fact there is nothing wrong with this code
> > > (ie it should be applied), the error was in the driver for the Dreamcast
> > > controller (the device, in general, into which the subdevices are
> > > plugged in and out).
> > > 
> > > I will post a fix for that.
> > > 
> > > Sorry again.
> > > 
> > So what exactly is supposed to be applied here?
> 
> The patch at the start of this thread - ie
> http://lkml.org/lkml/2008/2/24/125  - this should really go in now as it
> fixes a problem with current code.
> 
Ok, that's applied. Note that the original body was horribly word
wrapped, and your patch was not in -p1 format (while others in the series
are, for reasons that aren't entirely obvious).

> In addition there are two patch sets to add new device support:
> 
> http://lkml.org/lkml/2008/2/24/211    - maple controller
> 
> http://lkml.org/lkml/2008/2/24/121  (thread) - maple mouse
> 
This is not 2.6.25 material. Once you have Acked-by's from the input
folks, I'll queue these up in my 2.6.26 tree. The bus unplug thing is
rather unusual, I don't know if Greg has any comments on that or not.
