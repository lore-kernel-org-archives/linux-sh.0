From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 16 Nov 2012 01:01:07 +0000
Subject: Re: [PATCH 00/10] serial: sh-sci fixes - console PM, SCIFB, SMP lockup, etc.
Message-Id: <20121116010107.GA6068@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <509A0658.1010503@renesas.com>
 <509A0B4E.1030801@renesas.com>
In-Reply-To: <509A0B4E.1030801@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 07, 2012 at 04:18:38PM +0900, Shinya Kuribayashi wrote:
> On 11/7/2012 3:57 PM, Shinya Kuribayashi wrote:
> > Hi Paul and serial forks,
> [...]
> > Takashi YOSHII (4):
> >       serial: sh-sci: fix condition test to set SCBRR
> >       serial: sh-sci: support lower baud rate
> >       serial: sh-sci: mask SCTFDR/RFDR according to fifosize
> >       serial: sh-sci: fix common SCIFB regmap definition
> > 
> > Teppei Kamijou (1):
> >       serial: sh-sci: console runtime PM support (revisit)
> > 
> >  drivers/tty/serial/sh-sci.c | 140 ++++++++++++++++++--------------------------
> >  1 file changed, 56 insertions(+), 84 deletions(-)
> 
> Oops, I forgot to append proper From: author lines in five commits
> (patch 04/10 to 09/10).  Didn't mean to supersede your authoship.
> 
> I'd respin the patchset later, waiting for some feedback.

Can you please resend this with this fixed up if you want to get this
into 3.8?

thanks,

greg k-h
