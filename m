From: Marc Dietrich <marvin24@gmx.de>
Date: Thu, 11 Sep 2014 14:49:39 +0000
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Message-Id: <1848352.9OlbbQfLfy@fb07-iapwap2>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart9298235.REuW2h2BOe"
List-Id: <linux-sh.vger.kernel.org>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <16809905.2REViph6WO@fb07-iapwap2> <20140911141257.GC5149@katana>
In-Reply-To: <20140911141257.GC5149@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart9298235.REuW2h2BOe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Am Donnerstag, 11. September 2014, 16:12:58 schrieb Wolfram Sang:
> On Thu, Sep 11, 2014 at 02:17:16PM +0200, Marc Dietrich wrote:
> > > +		reg = <0x64>;
> > 
> > we had some discussions in the past how to represent i2c master devices in
> > device tree. The outcome was to use to a special representation to
> > distinguish them from slave devices, e.g. something like reg = <0x1
> > 0x64>, where the 0x1 would mean "master" device (0x0 -> slave). If
> > nothing is added, then it's also slave. The adapter address cell would
> > also need to be changed if this extension is used.
> 
> Please don't change the reg-layout which is around since forever.
> It will break all existing devicetrees. NAK.

it won't break existing device trees. It would only need to be extended for 
systems where the adapter uses master and slave modes (or if you add a master 
device to the i2c client list). So you need to change the device tree anyway.
All other setups can continue to use a single reg.

Thinking more about it, are there any i2c clients parsing the reg property 
directly? In this case I would agree, otherwise, only i2c core needs some 
update - right?

Marc

> > An alternative would be to use a special property (e.g. slave address),
> > but
> > that would encode the same value twice (or even three times).
> 
> As said, if all breaks we handle it at runtime.
> 
> Thanks,
> 
>    Wolfram

--nextPart9298235.REuW2h2BOe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJUEbaEAAoJEKyeR39HFBtoqLMH/RlB0UezRs64ZMKn/c+WMWun
Q6KC1Elene0gZ/XJrZ+mq8FKZmXYnVup/Sfy5aWBU6/WjqOlZIpNQXeeNb2WUl47
hFc76S+7OWXztnfz80071b3l3Q5rNJ8DeukRPFsB5Z8DMI/p+4ab8AcfO3og+z12
4fF5NxTgZIK0u7UUYub9487j+/K6rYw8lIxmB6XUZwtLBwsdVFmEfQdJd7WNNgFJ
B8Bcyslx4P5oi0JGZ44PnzK8Ovp+Z5E+33XqXCPa8dBZSG3WeB90jOAW9wIm7zHl
W8nGXTcQEz8gB1dsVBlUk8/maVxX/pHMT2UHu/xQ2N66VXgQfAc90Zl8voozNZc=
=yf3d
-----END PGP SIGNATURE-----

--nextPart9298235.REuW2h2BOe--

