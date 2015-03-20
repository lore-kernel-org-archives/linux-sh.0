From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Fri, 20 Mar 2015 07:44:47 +0000
Subject: Re: [PATCH 1/3] i2c: slave: rework the slave API
Message-Id: <20150320074447.GE10068@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
 <1426164123-8853-2-git-send-email-wsa@the-dreams.de>
 <20150319201751.GZ10068@pengutronix.de>
 <20150320071504.GA906@katana>
 <20150320072441.GA10068@pengutronix.de>
 <20150320073135.GC906@katana>
In-Reply-To: <20150320073135.GC906@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrey Danin <danindrey@mail.ru>, Marc Dietrich <marvin24@gmx.de>, Debora Grosse <debora@mds.com>, linux-kernel@vger.kernel.org

On Fri, Mar 20, 2015 at 08:31:35AM +0100, Wolfram Sang wrote:
>=20
> > > > > After more discussion, brave users, and additional datasheet eval=
uation,
> > > > > some API updates for the new I2C slave framework became imminent.=
 The
> > > > > slave events now get some easier to understand naming. Also, the =
event
> > > > > handling has been simplified to only send one event per interrupt.
> > > > what is an interrupt here? An event where the bus driver needs feed=
back
> > > > from the backend?
> > >=20
> > > More the other way around: when the bus driver needs to notify the
> > > backend. I wasn't 100% sure about the word 'interrupt', but then deci=
ded
> > > a HW slave support without interrupts would be so rare and adventurous
> > > that it is okay to use the term :)
> > Yeah, I agree on HW slave support without interrupts is hardly possible.
> > But I imagine that controllers differ in which situations they can issue
> > an interrupt so talking about them for generic code feels strange to me
> > because $flexiblecontrolerwithvariousirqs doesn't need to send more
> > events than $bareminimumcontroler.
>=20
> Do you have a better word at hand? "...to send one event per event"? :)
Maybe:

	Also, the event handling has been simplified to only need a
	single call to the slave callback when an action by the backend
	is required.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
