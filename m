From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Fri, 20 Mar 2015 07:42:14 +0000
Subject: Re: [PATCH 2/3] Documentation: i2c: describe the new slave mode
Message-Id: <20150320074214.GD10068@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
 <1426164123-8853-3-git-send-email-wsa@the-dreams.de>
 <20150319201137.GY10068@pengutronix.de>
 <20150320073012.GB906@katana>
In-Reply-To: <20150320073012.GB906@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrey Danin <danindrey@mail.ru>, Marc Dietrich <marvin24@gmx.de>, Debora Grosse <debora@mds.com>, linux-kernel@vger.kernel.org

Hello Wolfram,

On Fri, Mar 20, 2015 at 08:30:13AM +0100, Wolfram Sang wrote:
>=20
> > > +Finally, Linux can also be an I2C slave in case I2C controllers have=
 slave
> > > +support. Besides this HW requirement, one also needs a software back=
end
> > I wouldn't have written "Finally, ...". While it's great that we have
> > slave support now, being enthusiastic here looks strange if someone
> > reads it while slave support has become "normal".
>=20
> OK.
>=20
> > > +providing the actual functionality. An example for this is the slave=
-eeprom
> > > +driver, which acts as a dual memory driver. While another I2C master=
 on the bus
> > > +can access it like a regular eeprom, the Linux I2C slave can access =
the content
> > > +via sysfs and retrieve/provide information as needed. The software b=
ackend
> > > +driver and the I2C bus driver communicate via events. Here is a smal=
l graph
> > > +visualizing the data flow and the means by which data is transported=
. The
> > > +dotted line marks only one example. The backend could also use e.g. =
a character
> > > +device, or use in-kernel mechanisms only, or something completely di=
fferent:
> > Or something self contained, so the userspace part is actually optional
> > (but probably present most of the time).
>=20
> With "in-kernel mechanisms" I meant self-contained. Maybe "be in-kernel
> only"?
I'm sure "in-kernel mechanisms" wasn't in the mail I replied to. (Hmm,
or I must have missed that while reading.)

> > Another slave backend I have in mind is a bus-driver tester. That
> > wouldn't necessarily need a userspace part.
>=20
> Yes, I envisioned that, too.
>=20
> >=20
> > > +              e.g. sysfs        I2C slave events        I/O registers
> > > +  +-----------+   v    +---------+     v     +--------+  v  +-------=
-----+
> > > +  | Userspace +........+ Backend +-----------+ Driver +-----+ Contro=
ller |
> > > +  +-----------+        +---------+           +--------+     +-------=
-----+
> > > +                                                                | |
> > > +  ----------------------------------------------------------------+-=
-  I2C
> > > +  --------------------------------------------------------------+---=
-  Bus
> > > +
> > > +Note: Technically, there is also the I2C core between the backend an=
d the
> > > +driver. However, at this time of writing, the layer is transparent.
> > s/this/the/ ?
>=20
> Maybe.
>=20
> > > +The bus driver sends an event to the backend using the following fun=
ction:
> > > +
> > > +	ret =3D i2c_slave_event(client, event, &val)
> > > +
> > > +'client' describes the i2c slave device. 'event' is one of the speci=
al event
> > > +types described hereafter. 'val' holds an u8 value for the data byte=
 to be
> > > +read/written and is thus bidirectional. The pointer to val must alwa=
ys be
> > > +provided even if val is not used for an event. 'ret' is the return v=
alue from
> > Does that mean that I have to pass a valid address, or can I use NULL,
> > too?
>=20
> Is NULL a valid pointer to val?
NULL is a pointer and you didn't wrote about "valid" above. I just
wondered if the necessity just comes from the fact that the function
takes 3 parameters and so you have to give it 3 (this wouldn't needed to
be pointed out IMHO) or if the value must be valid (then the wording
isn't optimal).
Is there a technical reason to require val to be valid?

> > I didn't look into the actual implementation yet, but if I understand
> > correctly a slave driver only sees I2C_SLAVE_READ_REQUESTED once and
> > then only one I2C_SLAVE_READ_PROCESSED per byte, right? Does the slave
>=20
> Right.
>=20
> > driver gets noticed somehow if a previously requested byte doesn't make
> > it on the wire? Otherwise you cannot correctly maintain e.g. the current
>=20
> Some HW can do this, but not all. That would maybe be another candidate
> for an optional event. Although, people should try hard to not need it.
>=20
> > read position of the eeprom driver, do you? (That's a bit like one of
> > the problems with buffer support you pointed out further down.)
>=20
> You need to assume that if the next byte is requested, the previous byte
> made it to the bus. So, you should do pre-increment in
> I2C_SLAVE_READ_PROCESSED, not post-increment. I didn't want to write
This might be a correctness problem, right? If we cannot fix it (with
the current slave abstraction) should this be pointed out somewhere; at
least in the eeprom driver as this will probably be the reference for
the next backend?

> this example so explicit because not all slave-backends will have a
> position pointer. And besides, it might make sense to extract the code for
> managing a position pointer from the slave-eeprom driver. Then, we'd
> have only one trusted implementation of EEPROM-alike behaviour and
> people can concentrate on reacting to reads/writes.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
