From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 30 Dec 2007 13:38:24 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom device
Message-Id: <1199021904.6222.7.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1198774339.6170.11.camel@localhost.localdomain>
	 <1198796281.4833.31.camel@localhost>
In-Reply-To: <1198796281.4833.31.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>


On Thu, 2007-12-27 at 14:58 -0800, Joe Perches wrote:
> On Thu, 2007-12-27 at 16:52 +0000, Adrian McMenamin wrote:
> > This patch adds support for the CD-Rom drive on the SEGA Dreamcast.
> 
> Because it was already so close, might as well make it checkpatch clean.
> 
> I also added a function gdrom_is_busy() to make a couple of tests
> fit on a single line and perhaps easier to read.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
Not really for me to decide if this gets applied - I'll leave that to
Paul as the maintainer. But I have no objection to them :)

