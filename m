From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Apr 2009 07:03:14 +0000
Subject: Re: [RFC][patch] filesystem: Vmufat filesystem, version 4
Message-Id: <20090414070314.GB29075@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1239654768.6542.10.camel@localhost.localdomain> <20090413210030.GA14847@linux-sh.org> <1239658604.6542.28.camel@localhost.localdomain> <20090413215949.GD14847@linux-sh.org> <1239692429.6538.2.camel@localhost.localdomain>
In-Reply-To: <1239692429.6538.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, Josef 'Jeff' Sipek <jeffpc@josefsipek.net>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Apr 14, 2009 at 08:00:29AM +0100, Adrian McMenamin wrote:
> On Tue, 2009-04-14 at 06:59 +0900, Paul Mundt wrote:
> 
> > This file system is tied directly to the VMU. Assumptions about the
> > on-disk format, block numbering limitations, etc. are all VMU
> > constraints, and papering over that in the Kconfig text is not
> > sufficient. This file system is and always will be tied to the VMU, and
> > you really do not want to decouple the two. What you do in loopback mode
> > for testing is your own business, but this will not work in the way
> > people expect on a fixed disk. You are only making things harder on
> > yourself by insisting that this is somehow generic.
> > 
> > The file system at least wants a dependency on the VMU (and I suppose
> > mtdblock) itself.
> 
> Why won't it work on a fixed disk "in the way people expect"? Granted
> they'd be eccentric to format a disk in this way but there is no
> inherent reason why this file system *has* to be tied to a VMU.
> 
Everything about the on-disk format is tied to the VMU. Until that sinks
in, don't bother sending me email, thanks.
