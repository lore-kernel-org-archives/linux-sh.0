From: Simon Horman <horms@verge.net.au>
Date: Tue, 10 Jun 2014 01:56:54 +0000
Subject: Re: [PATCH v2 04/05] staging: board: Initial board staging support
Message-Id: <20140610015650.GG30874@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140529131650.2329.3197.sendpatchset@w520>
 <20140529131732.2329.50630.sendpatchset@w520>
 <20140529132034.GB15585@mwanda>
 <CANqRtoTzOn5d9qB85sXvmLYhoTDMDtbjSkLbz9V4FRmzFM3ycQ@mail.gmail.com>
 <20140529231001.GC2353@verge.net.au>
 <CANqRtoTLznzU1mJRJMjNgr0pAY8fY__-12qE77Dz97n47FekhQ@mail.gmail.com>
In-Reply-To: <CANqRtoTLznzU1mJRJMjNgr0pAY8fY__-12qE77Dz97n47FekhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel <linux-kernel@vger.kernel.org>, devel <devel@driverdev.osuosl.org>, SH-Linux <linux-sh@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>

On Fri, Jun 06, 2014 at 09:07:44PM +0900, Magnus Damm wrote:
> On Fri, May 30, 2014 at 8:10 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, May 29, 2014 at 10:27:30PM +0900, Magnus Damm wrote:
> >> Hi Dan,
> >>
> >> On Thu, May 29, 2014 at 10:20 PM, Dan Carpenter
> >> <dan.carpenter@oracle.com> wrote:
> >> > On Thu, May 29, 2014 at 10:17:32PM +0900, Magnus Damm wrote:
> >> >> --- /dev/null
> >> >> +++ work/drivers/staging/board/Kconfig        2014-05-29 21:40:41.000000000 +0900
> >> >> @@ -0,0 +1,7 @@
> >> >> +config STAGING_BOARD
> >> >> +     boolean "Staging Board Support"
> >> >> +     help
> >> >> +       Select to enable per-board staging support code.
> >> >> +
> >> >> +       If in doubt, say N here.
> >> >> +
> >> >
> >> > Actually, you're probably going to need to add a bunch of dependencies
> >> > here or it will break "make randconfig" right away.  Sorry that I forgot
> >> > about this in the first review.
> >>
> >> Good point, thanks for checking. I will have a look at this and add
> >> dependencies to make sure it builds on a wide range of platforms.
> >
> > Hi Magnus,
> >
> > let me know if you would like me to perform some build-testing.
> 
> Hey Simon,
> 
> Thanks for the offer. When you have time, can you please feed V3 into
> your build test setup?
> 
> [PATCH v3 00/05] staging: Emma Mobile USB driver and KZM9D board code V3
> [PATCH v3 01/05] staging: emxx_udc: Add Emma Mobile USB Gadget driver
> [PATCH v3 02/05] staging: emxx_udc: I/O memory and IRQ resource support
> [PATCH v3 03/05] staging: emxx_udc: Add TODO file
> [PATCH v3 04/05] staging: board: Initial board staging support
> [PATCH v3 05/05] staging: board: kzm9d: Board staging support for emxx_udc

Hi Magnus,

my test was less exciting as I had hoped as STAGING is not widely
enabled in defconfigs.

I compiled v3.15-rc8 with the patches above applied using
the defconfigs and allmodconfigs for a wide range of architectures.
The result was that all of the configs that built for v3.15-rc8
also built with your patches applied.

In other words, I did not find a problem.
