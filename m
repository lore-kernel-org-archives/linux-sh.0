From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 02 Apr 2015 03:38:19 +0000
Subject: Re: [PATCH v2 2/4] Documentation: i2c: describe the new slave mode
Message-Id: <20150402033815.GA1429@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
List-Id: <linux-sh.vger.kernel.org>
References: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
 <1427099199-3628-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdVVLVXmbtan1rKtDrSrJ_nKO_K5Xx4jAjcb5ow_ChDVhg@mail.gmail.com>
In-Reply-To: <CAMuHMdVVLVXmbtan1rKtDrSrJ_nKO_K5Xx4jAjcb5ow_ChDVhg@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2015 at 02:17:47PM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Mon, Mar 23, 2015 at 9:26 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > --- /dev/null
> > +++ b/Documentation/i2c/slave-interface
>=20
> > +I2C slave events
> > +----------------
> > +
> > +The bus driver sends an event to the backend using the following funct=
ion:
> > +
> > +       ret =3D i2c_slave_event(client, event, &val)
> > +
> > +'client' describes the i2c slave device. 'event' is one of the special=
 event
> > +types described hereafter. 'val' holds an u8 value for the data byte t=
o be
> > +read/written and is thus bidirectional. The pointer to val must always=
 be
> > +provided even if val is not used for an event, i.e. don't use NULL her=
e. 'ret'
> > +is the return value from the backend. Mandatory events must be provide=
d by the
> > +bus drivers and must be checked for by backend drivers.
> > +
> > +Event types:
> > +
> > +* I2C_SLAVE_WRITE_REQUESTED (mandatory)
> > +
> > +'val': unused
> > +'ret': always 0
> > +
> > +Another I2C master wants to write data to us. This event should be sen=
t once
> > +our own address and the write bit was detected. The data did not arriv=
e yet, so
> > +there is nothing to process or return. Wakeup or initialization probab=
ly needs
> > +to be done, though.
> > +
> > +* I2C_SLAVE_READ_REQUESTED (mandatory)
>=20
> I'm wondering whether these should be called I2C_SLAVE_READ_FIRST...

I considered that but decided against it. The difference to WRITE was
one reason. I think there was another I found when implementing the
update, but that one I can't recall right now :(


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHLmmAAoJEBQN5MwUoCm29rcQAJZpIs2jqzx0BB8la7qBsQtw
M/9/Y/qWWDFl4HxfhP9KOFmjhs2nCIFYFzozKoXyMlG9pNnrT2SDzTTYq3bPZk+M
uXRW4QwT4LQvm+oYRMLuVX74Hn19YxsuuUGgJ7yUynCNUV57Bc9GyOYivRnSyOxU
eqn77q48argNNJOc55kZp51jQQcOGXlMypUNeK6HhopYXi6S6on3XGAAo5oK53Pb
ogyYKf5eRl7ChjSMYiYtJeRGFhkLmKXrIGJw47n87XPmICx3naYmpK6C0IUy8zZx
7wMQfj1OA4B5tPD/OxQwEeA9zb4JpZ7bWB+Gjss1zG4BGE7Ys80d71tUnI1E0zUy
fEuI6QqNsuxi1ysFtvOOXdWS+hw/Z4BrKaVi8kNEPjNfU/nfgpV5FLCKJ2Tqs45/
R9wd03WBHQUcTLXNxkQ8xMmnoqHNfMCl0ZMfGxKSrxuWah6q258ScrL97M6OBrYI
GodAIfL8WUoVdgtYe5BsLSCS7Qb1GSSwZ8asvVkGApIktDExYczKzufSsiH/Cxoq
poxoHazZa6UCIYBNLg6aIUbI1QwZxXjfuvtz5IkeLLt5Cxh1D5rNBZ+qom05lLKY
E3uRcQa3OydWlfRZ0u3+PPF1gfiiBicyoZ6i1DJKoWlXFqUOjjyV1ql08AQCYZ7O
vmOyskN2dKFP+YUQGBR5
=cgxY
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
