From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 28 Dec 2007 03:41:36 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom device
Message-Id: <20071228034136.GA27806@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1198774339.6170.11.camel@localhost.localdomain> <1198796281.4833.31.camel@localhost> <200712271949.02942.vapier@gentoo.org>
In-Reply-To: <200712271949.02942.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: Joe Perches <joe@perches.com>, Adrian McMenamin <adrian@newgolddream.dyndns.info>, Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Thu, Dec 27, 2007 at 07:49:01PM -0500, Mike Frysinger wrote:
> On Thursday 27 December 2007, Joe Perches wrote:
> > I also added a function gdrom_is_busy() to make a couple of tests
> > fit on a single line and perhaps easier to read.
> 
> i'd tend to agree it does make it easier to read, however you didnt make it 
> inline which means gcc may not inline it which means there's pointless 
> overhead of doing a function call.
> 
These days GCC is usually smart enough to automatically inline things
that are that small, it doesn't need to be explicitly labelled. If your
toolchain doesn't inline that gdrom_is_busy() implementation, get a
better toolchain.

> otherwise, arbitrary breaking on 80 cols actually makes the code harder to 
> read for no gain.

Hey now, some of us have no intention of giving up our 80x25 consoles,
not everyone buys in to this whole newfangled X thing. ;-)

More than 80 columns is generally fine so long as it's done so tastefully
rather than arbitrarily based on a larger console width. However, if it
can be split up cleanly for 80 columns, then it should be. ie, use common
sense, rather than blindly adhering to the whims of an anal-retentive
script.
