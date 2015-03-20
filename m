From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 20 Mar 2015 07:30:13 +0000
Subject: Re: [PATCH 2/3] Documentation: i2c: describe the new slave mode
Message-Id: <20150320073012.GB906@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UHN/qo2QbUvPLonB"
List-Id: <linux-sh.vger.kernel.org>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
 <1426164123-8853-3-git-send-email-wsa@the-dreams.de>
 <20150319201137.GY10068@pengutronix.de>
In-Reply-To: <20150319201137.GY10068-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Andrey Danin <danindrey-JGs/UdohzUI@public.gmane.org>, Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>, Debora Grosse <debora-HRUOeNTICTI@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +Finally, Linux can also be an I2C slave in case I2C controllers have s=
lave
> > +support. Besides this HW requirement, one also needs a software backend
> I wouldn't have written "Finally, ...". While it's great that we have
> slave support now, being enthusiastic here looks strange if someone
> reads it while slave support has become "normal".

OK.

> > +providing the actual functionality. An example for this is the slave-e=
eprom
> > +driver, which acts as a dual memory driver. While another I2C master o=
n the bus
> > +can access it like a regular eeprom, the Linux I2C slave can access th=
e content
> > +via sysfs and retrieve/provide information as needed. The software bac=
kend
> > +driver and the I2C bus driver communicate via events. Here is a small =
graph
> > +visualizing the data flow and the means by which data is transported. =
The
> > +dotted line marks only one example. The backend could also use e.g. a =
character
> > +device, or use in-kernel mechanisms only, or something completely diff=
erent:
> Or something self contained, so the userspace part is actually optional
> (but probably present most of the time).

With "in-kernel mechanisms" I meant self-contained. Maybe "be in-kernel
only"?

> Another slave backend I have in mind is a bus-driver tester. That
> wouldn't necessarily need a userspace part.

Yes, I envisioned that, too.

>=20
> > +              e.g. sysfs        I2C slave events        I/O registers
> > +  +-----------+   v    +---------+     v     +--------+  v  +---------=
---+
> > +  | Userspace +........+ Backend +-----------+ Driver +-----+ Controll=
er |
> > +  +-----------+        +---------+           +--------+     +---------=
---+
> > +                                                                | |
> > +  ----------------------------------------------------------------+-- =
 I2C
> > +  --------------------------------------------------------------+---- =
 Bus
> > +
> > +Note: Technically, there is also the I2C core between the backend and =
the
> > +driver. However, at this time of writing, the layer is transparent.
> s/this/the/ ?

Maybe.

> > +The bus driver sends an event to the backend using the following funct=
ion:
> > +
> > +	ret =3D i2c_slave_event(client, event, &val)
> > +
> > +'client' describes the i2c slave device. 'event' is one of the special=
 event
> > +types described hereafter. 'val' holds an u8 value for the data byte t=
o be
> > +read/written and is thus bidirectional. The pointer to val must always=
 be
> > +provided even if val is not used for an event. 'ret' is the return val=
ue from
> Does that mean that I have to pass a valid address, or can I use NULL,
> too?

Is NULL a valid pointer to val?

> > +the backend. Mandatory events must be provided by the bus drivers and =
must be
> > +checked for by backend drivers.
> Currently all commands are mandatory. Does it make sense to mark the
> events accordingly already now? Do you expect the set of events to
> grow?

Yes, support for general call address or device ids might be added
somewhen.

>=20
> > +* I2C_SLAVE_READ_PROCESSED (mandatory)
> > +
> > +'val': backend returns next byte to be sent
> > +'ret': always 0
> > +
> > +The bus driver requests the next byte to be sent to another I2C master=
 in
> > +'val'. Important: This does not mean that the previous byte has been a=
cked or
> > +even has been put on the wires! Most hardware requests the next byte w=
hen the
> > +previous one is still to be shifted out to ensure seamless transmissio=
n. If the
> > +master stops reading after the previous byte, the next byte is never u=
sed. It
> > +probably needs to be sent again on the next I2C_SLAVE_READ_REQUEST, de=
pending a
> > +bit on your backend.
> I didn't look into the actual implementation yet, but if I understand
> correctly a slave driver only sees I2C_SLAVE_READ_REQUESTED once and
> then only one I2C_SLAVE_READ_PROCESSED per byte, right? Does the slave

Right.

> driver gets noticed somehow if a previously requested byte doesn't make
> it on the wire? Otherwise you cannot correctly maintain e.g. the current

Some HW can do this, but not all. That would maybe be another candidate
for an optional event. Although, people should try hard to not need it.

> read position of the eeprom driver, do you? (That's a bit like one of
> the problems with buffer support you pointed out further down.)

You need to assume that if the next byte is requested, the previous byte
made it to the bus. So, you should do pre-increment in
I2C_SLAVE_READ_PROCESSED, not post-increment. I didn't want to write
this example so explicit because not all slave-backends will have a
position pointer. And besides, it might make sense to extract the code for
managing a position pointer from the slave-eeprom driver. Then, we'd
have only one trusted implementation of EEPROM-alike behaviour and
people can concentrate on reacting to reads/writes.

> > +* I2C_SLAVE_STOP (mandatory)
> > +
> > +'val': unused
> > +'ret': always 0
> > +
> > +A stop condition was received. This can happen anytime and the backend=
 should
> > +reset its state to be able to receive new requests.
> While being obvious when you understood i2c, "reset its state" could be
> misleading. Only the transfer specific stuff should be reset. I expect
> the eeprom example to not reset the current position on STOP.

OK. Being precise is better, I agree.


--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVC8yEAAoJEBQN5MwUoCm2LF8P/0oCEwcEPeEvp7U7vtNG92BW
yWguSIhGFD+USPNOzib+cnyTu28vYh1MINK7czjz5TBPwfCAfFfhsP+r617B83Fe
/BJc7FUFafkdOlH9vz8u5eQZD/0K+DS5hg1mJdqfRWRCcud67iuv0nrAZrvjZIga
3OdvA5dri5AhYCjnjtCnP0J6WZeV7AVhKqHVPYVFROULTw5aZ2Xx+H2VTA7BXLsi
gtzxGy0Razg2U1n4lw9YWerPytBmT0tW6jWOpHoChQdkCtdYUOD7+Zkzrtir6+5D
jzU2xyCQAaELl6qLCy6z9HnZY403xzE8mFzZTGf0PXIpGn97xeUEFzLSva0ZEQEU
VOP9jeaTCKx7PmopQ5LF8V7aRNvf3zwtriJGd1OEfkIvS8IaEfqgyGhu72cuopND
tfsVEZ45Pqop8CJl4DpaMjQrjLgkiaLuKdwwyliwkx2pu5sm4qrFM+zyAz29zaN/
cvUgzUOUJSB34a3oiCkjO+a7H03N1rWtENYanAMH0XR2HAgxypYokSxfLCrvcCIv
vImLwT0Rjk/83iFFJR1Dj/y2ljx9Z5R0HrCYqYebHucEbSNR4A2dQDrr73Ke+41w
0pp8xmTzByUddutwWGMOL1YxMrac/4jSYFeecs6fC4Bfna08dPzc9tJ7+37zruJ6
fDED+L3km0C3hk1h6YP8
=QAv4
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
