From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Date: Mon, 24 Mar 2008 16:04:30 +0000
Subject: Re: [PATCH] 3/3 maple: update bus driver to support Dreamcast VMU
Message-Id: <20080324160429.GG2899@logfs.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1206207805.6324.13.camel@localhost.localdomain>
	<1206209786.6324.41.camel@localhost.localdomain>
	<20080324033344.GB15872@linux-sh.org>
	<20080324144647.GC2899@logfs.org>
	<1206371178.6283.37.camel@localhost.localdomain>
	<20080324152952.GF2899@logfs.org>
	<1206373900.6283.39.camel@localhost.localdomain>
In-Reply-To: <1206373900.6283.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Andrew Morton <akpm@osdl.org>, linux-sh <linux-sh@vger.kernel.org>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, MTD <linux-mtd@lists.infradead.org>, dwmw2 <dwmw2@infradead.org>

On Mon, 24 March 2008 15:51:40 +0000, Adrian McMenamin wrote:
> On Mon, 2008-03-24 at 16:29 +0100, Jörn Engel wrote:
> > On Mon, 24 March 2008 15:06:18 +0000, Adrian McMenamin wrote:
> > > 
> > > I don't think I have any alternative here. The problem is that the bus
> > > checks periodically (every HZ ticks but that could be changed) if a
> > > device remains connected to the system by queueing a status command. (If
> > > the status command is replied to with a "No response" then that
> > > indicates to the bus that the device has been removed.
> > 
> > Where does this queueing happen?  Somewhere in the kernel where we can
> > control it or in hardware?
> 
> Well, the queuing of the status command is under software control.

Then we should be fine.  I'll try to beat the code into submission.

Jörn

-- 
Joern's library part 7:
http://www.usenix.org/publications/library/proceedings/neworl/full_papers/mckusick.a
