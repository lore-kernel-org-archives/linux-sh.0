From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 28 Jul 2011 20:09:10 +0000
Subject: Re: [PATCH 1/2] MMC / TMIO: Fix build issue related to struct
Message-Id: <Pine.LNX.4.64.1107282205110.20737@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201107262049.15333.rjw@sisk.pl> <201107262050.23379.rjw@sisk.pl>
 <Pine.LNX.4.64.1107272236510.7435@axis700.grange> <201107272356.16817.rjw@sisk.pl>
In-Reply-To: <201107272356.16817.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, 27 Jul 2011, Rafael J. Wysocki wrote:

> On Wednesday, July 27, 2011, Guennadi Liakhovetski wrote:
> > (added MMC maintainer to CC:)
> > 
> > On Tue, 26 Jul 2011, Rafael J. Wysocki wrote:
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Fix build issue caused by undefined struct scatterlist in
> > > drivers/mmc/host/tmio_mmc.c.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > A nitpick, if I may: sCatterlist comes before sPinlock in my versions of 
> > most popular alphabets;-) Please, fix (or maybe Chris can fix it himself), 
> 
> I'm not sure what you mean exactly (perhaps it's too late).

I mean, that the headers are atm sorted alphabetically and should remain 
so, therefore you should add the new header one line higher. As for 
compile failure or not: I haven't seen any compile failures myself, but 
the patch is academically correct, because structs, declared in tmio_mmc.h 
embed struct scatterlist, therefore the header has to be included in that 
header too.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
