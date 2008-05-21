From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Date: Wed, 21 May 2008 08:50:33 +0000
Subject: Re: [PATCH 00/03][RFC] Reusable UIO Platform Driver
Message-Id: <20080521085033.GA29607@digi.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080520105132.1474.73941.sendpatchset@rx1.opensource.se> <20080520210713.GE3220@local> <aec7e5c30805202031x62b3b463lfde0b9e7eb32d35@mail.gmail.com> <20080521064938.GA11580@digi.com> <20080521074950.GA27310@linux-sh.org> <20080521080503.GA28751@digi.com> <aec7e5c30805210122w5bdb8443r69bb7776e085276b@mail.gmail.com>
In-Reply-To: <aec7e5c30805210122w5bdb8443r69bb7776e085276b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, "Hans J. Koch" <hjk@linutronix.de>, linux-kernel@vger.kernel.org, gregkh@suse.de, linux-sh@vger.kernel.org, Katsuya MATSUBARA <matsu@igel.co.jp>

Hello,

Magnus Damm wrote:
> On Wed, May 21, 2008 at 5:05 PM, Uwe Kleine-K=F6nig
> <Uwe.Kleine-Koenig@digi.com> wrote:
> > @Magnus: Maybe you can provide the userspace part of the driver?
> > How is that mapping used there?
>=20
> [Added Matsubara-san as CC]
>=20
> Sure, here is a little test program. Have a look at "uio_mem". The
> "address" member contains the physical address that can be used for
> bus mastering DMA. Compare that to "iomem" which is the pointer to the
> virtual memory area in user space.
>=20
> Hope this helps!
Yes it does.  I thought the physical address is stored in internal_addr
and the virtual in addr, but it's the other way round.  Thanks.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisach, =
Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962
