From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 12 Sep 2014 08:33:48 +0000
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Message-Id: <20140912083348.GA1289@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
List-Id: <linux-sh.vger.kernel.org>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <1591383.Xdy91rktuP@fb07-iapwap2> <20140911145421.GE5149@katana>
 <9935938.eKOCvCAtLt@fb07-iapwap2>
In-Reply-To: <9935938.eKOCvCAtLt@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Why do you want DT to be involved at all?
>=20
> Imagine a device which supports both, slave or master mode. The driver ne=
eds=20
> to know in which mode it should operate. This cannot be hard coded, becau=
se on=20
> different boards, different modes can be used.

Okay, it sounds weird to me that a device is not able to switch between
master and slave, but if you say so. Also, solving this issue would also
handle potential weird IP blocks which can be slave only, right?

What if you use two different adapter drivers or compatibles? One for
master-mode, one for slave-mode (slave could leave algo->master_xfer
empty, so the slave mode driver cannot send packets). I'm brainstorming
here, so while it should work IMO I will probably need a second thought.

So, in the DT you would have a block registering the I2C slave core
which binds to a simple driver providing reg_slave/unreg_slave and
pass on the slave-event. Then you could instantiate slave clients as
said before.

Maybe we need a real world example?

> The point is, that if we define a dt binding for master device on slave=
=20
> adapters it will be there forever. So even if it makes no sense for the=
=20
> example eeprom simulator (or even our embedded controller), it may make s=
ense=20
> for other or future devices.

I don't know what you mean here. Again, an example might help?

Thanks,

   Wolfram


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEq/sAAoJEBQN5MwUoCm2fhQQAKI7BwTUMzwzP7Wm0RjEUm13
YqFY2XbBIHIbKLeOMltZ0HMtaCuc4VJmlcatpFn3539HpB6XAOjnl9Rce7XxTbgA
NBaFitahMwyqFv+VBFPdNQHgQc4sVkKqCUzjk+p9S+8J01FcjHZbYFqNc3ci3wj3
kAl5B8xXJ8QXQRxH1cBSNj5/Ac8WgzOVq/wvvdgzKORDT/o+L8GksFeBTkkbDicv
FQBSr9EBXBeq1FNkFkkT3jlqXCQsWfqZjXAjB64QBRWE+FjKBKvRZmUMmaCoz3vC
2jZ5Vp6GxHpWxs1PGxu5yNhgwBUYSCeiTNDS2EKQkVG2UPnZz3R60EbEPisb9qkx
tdYPBQPbV/pR4XJZV0Z3L/KFP17Ts2bRUovnpMweRsyBbhXUVgtOlLK56p0ahN2Q
H7u/e/NT4fDKA46dBxxLHZNrGVnw03JeiTluFUdGnLXItAjsO/vvDLpRN42ylb+K
Yb5Fi37s7Z9OgZALazfpxGDk6wmE9GcVwBS5KwJy9nt2kmYrSIxRWP1ur9XE9RnV
ALki0WmMVPD1F9Vl5QUxGRw29ESmO2zbfQwH8KqGpndlRmNM1Ml332QeZuROTOuP
8JvFAFbDgn0QMRfDyOV6Xj47+3T9+Pey2Cl5Ih/z6y+U7GFOt0h6zgv4a9pEW6af
nQS++k8HsEeFK318YVHv
=IiNd
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
