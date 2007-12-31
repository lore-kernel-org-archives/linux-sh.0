From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 31 Dec 2007 05:23:36 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom device
Message-Id: <20071231052336.GA29275@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1198774339.6170.11.camel@localhost.localdomain> <1198796281.4833.31.camel@localhost> <1199021904.6222.7.camel@localhost.localdomain>
In-Reply-To: <1199021904.6222.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Joe Perches <joe@perches.com>, Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Sun, Dec 30, 2007 at 01:38:24PM +0000, Adrian McMenamin wrote:
> On Thu, 2007-12-27 at 14:58 -0800, Joe Perches wrote:
> > On Thu, 2007-12-27 at 16:52 +0000, Adrian McMenamin wrote:
> > > This patch adds support for the CD-Rom drive on the SEGA Dreamcast.
> > 
> > Because it was already so close, might as well make it checkpatch clean.
> > 
> > I also added a function gdrom_is_busy() to make a couple of tests
> > fit on a single line and perhaps easier to read.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > 
> Not really for me to decide if this gets applied - I'll leave that to
> Paul as the maintainer. But I have no objection to them :)

Both patches are fine with me, but it is ultimately Jens (as the
drivers/cdrom authority) that will have to decide whether to sign off on
the GDROM patches or not, and through which tree the patches will end up
being merged. I can certainly merge them through my tree with his
Acked-by if that's deemed the most convenient.
