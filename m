From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Fri, 12 Sep 2014 08:58:36 +0000
Subject: Re: [RFC 0/4] i2c: slave support framework for Linux devices
Message-Id: <20140912085836.GS3755@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Wolfram,

On Tue, Sep 09, 2014 at 04:54:26PM +0200, Wolfram Sang wrote:
> Finally, here is my take on the often desired feature that Linux can not =
only
> be an I2C master, but also an I2C slave. Compared to my draft sent out la=
st
> week, this RFC has been tested on hardware (Renesas Lager board) and work=
s \o/
>=20
> One big part still missing is documentation, so brave ones need to "use t=
he
> source". However, this approach turned out to be even less intrusive than
> expected, so that is hopefully a good sign.
Some thoughts from reading through your patch set:

- If I understand correctly you cannot register an i2c slave without
  also registering a master, right? I don't think this is troubling in
  practice, is it?
  For abstraction I would prefer to make these different concepts
  though.

- The IMHO most (even only?) useful slave is "i2cslvdev", i.e. a
  userspace device. With that you wouldn't need device tree stuff, the
  driver would just offer the device if supported. Userspace then could
  care about the rest (slave address, functionality, ...).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
