From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Date: Wed, 21 May 2008 08:05:03 +0000
Subject: Re: [PATCH 00/03][RFC] Reusable UIO Platform Driver
Message-Id: <20080521080503.GA28751@digi.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080520105132.1474.73941.sendpatchset@rx1.opensource.se> <20080520210713.GE3220@local> <aec7e5c30805202031x62b3b463lfde0b9e7eb32d35@mail.gmail.com> <20080521064938.GA11580@digi.com> <20080521074950.GA27310@linux-sh.org>
In-Reply-To: <20080521074950.GA27310@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, "Hans J. Koch" <hjk@linutronix.de>, linux-kernel@vger.kernel.org, gregkh@suse.de, linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Wed, May 21, 2008 at 08:49:38AM +0200, Uwe Kleine-K?nig wrote:
> > Magnus Damm wrote:
> > >         Extending uio_pdrv driver with a chunk of physically
> > > contiguous memory isn't a big deal though.
> > I wonder how you use that memory.  Isn't it just some kind of shared
> > memory?  If so, why not use normal shared memory?  Do you really need
> > that?
> >=20
> Physically contiguous memory is a real requirement, especially for DMA.
> I'm not sure what's confusing about that?
I got that, yes.  The problem is I don't see how you can use it for DMA.
The physical address is stored in info->mem[$last].internal_addr and if
there is a way to access that variable from user space, I don't see it
and would appretiate a hint.  Sorry for not expressing my concern more
clear at the first go.  I hope it's understandable now.

@Magnus: Maybe you can provide the userspace part of the driver?
How is that mapping used there?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisach, =
Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962
