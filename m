From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Sun, 23 Nov 2014 18:52:00 +0000
Subject: Re: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
Message-Id: <20141123185200.GD4431@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <20141121071941.GK27002@pengutronix.de>
 <20141121141624.GT27002@pengutronix.de>
 <20141122181406.GC9698@katana>
In-Reply-To: <20141122181406.GC9698@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hallo Wolfram,

On Sat, Nov 22, 2014 at 07:14:06PM +0100, Wolfram Sang wrote:
> > > > +	case I2C_SLAVE_REQ_READ_END:
> > > > +		eeprom->buffer_idx++;
> > > You don't check here for buffer_idx >=3D ARRAY_SIZE(buffer)?
> > > Ditto in the I2C_SLAVE_REQ_WRITE_END case.
> > I just noticed that buffer_idx is an u8, so it overflows at 255+1. So
> > the probe routine should error out if size is bigger than 256.
>=20
> But size is currently fixed to 256, so all is fine. Yes, if we extend it
> for bigger sizes, all that stuff needs to be taken care of, right.
yeah, it's well hidden, but true. So IMHO worth a comment.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
