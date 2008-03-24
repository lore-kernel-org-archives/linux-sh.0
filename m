From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 24 Mar 2008 14:46:31 +0000
Subject: Re: [PATCH] 2/3 mtd: add support for flash on the SEGA Dreamcast Visual Memory Unit
Message-Id: <20080324144630.GA23826@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1206207805.6324.13.camel@localhost.localdomain>
	<1206209035.6324.29.camel@localhost.localdomain>
	<20080322183200.GD19347@logfs.org>
	<1206211147.6324.48.camel@localhost.localdomain>
	<20080324020832.GA13935@linux-sh.org>
	<1206360384.6283.11.camel@localhost.localdomain>
	<20080324132101.GA2899@logfs.org>
	<1206367120.6283.15.camel@localhost.localdomain>
	<20080324141043.GB2899@logfs.org>
	<1206369796.6283.19.camel@localhost.localdomain>
In-Reply-To: <1206369796.6283.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Andrew Morton <akpm@osdl.org>, J?rn Engel <joern@logfs.org>, MTD <linux-mtd@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Mon, Mar 24, 2008 at 02:43:16PM +0000, Adrian McMenamin wrote:
> On Mon, 2008-03-24 at 15:10 +0100, J??rn Engel wrote:
> > On Mon, 24 March 2008 13:58:40 +0000, Adrian McMenamin wrote:
> > > 
> > > Tempting as it is to continue the war, discretion will be the better
> > > part of valour here and I will give you the last word.
> > > 
> > > Of course I don't mind you sending patches. Indeed it would be very
> > > helpful and generous of you to do so.
> > 
> > Good.  The first four shouldn't change any behaviour.  Number five flips
> > positive error returns into negative ones.  I believe the old behaviour
> > is a bug.  Worth a second look to make sure.
> > 
> > All five patches are attached.  Hope that doesn't cause any problems.
> 
> Well, I haven't got round to applying them and testing them yet, though
> they look ok, obviously, except for one thing: I'm pretty much where you
> are on the goto versus return thing, but got pretty clear instructions
> on a previous patch from Andrew Morton that using gotos to ensure
> functions limit the number of return points is the way to go.
> 
The gotos help clean up the error path when you have something to do. In
this case there's nothing going on but a NULL return, so it really
doesn't matter one way or the other. Most people tend to avoid the goto
if you really have nothing to do in an error path.
