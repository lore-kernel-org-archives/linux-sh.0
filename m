From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 05 May 2014 15:51:44 +0000
Subject: Re: rcar-i2c: always reads a byte
Message-Id: <20140505155143.GB13467@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GID0FwUMdk1T2AWN"
List-Id: <linux-sh.vger.kernel.org>
References: <531F3686.7050808@codethink.co.uk>
 <20140311164043.GA1179@katana>
 <531F3CD3.4030408@codethink.co.uk>
 <531F438D.80001@codethink.co.uk>
In-Reply-To: <531F438D.80001@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >>>The system issues an address transaction followed by a single byte
> >>>read.
> >>
> >>This fits to my observation that the rcar driver cannot do SMBUS_QUICK
> >>(e.g. via i2cdetect). I assumed that handling a length of 0 is broken. I
> >>haven't had a deeper look yet, so I can't say much. So, you either go
> >>for it yourself, or you wait until I posted my IIC enablement series for
> >>Lager. Then, you can switch to the IIC core with the sh_mobile driver.
> >>That one does SMBUS_QUICK correctly.
> >
> >I'll have a deeper look into this, I think there may be a solution.
>=20
> I've tried issuing the ESG + FSB  bits as a command, however that
> did not work.

So, I experimented today as well. I don't think it is possible to have
zero-length support. I'll cook up a patch to disable them. Come to think
of it, it should be even for stable since I assume SMBUS_QUICK_WRITE
will also put a byte on the bus. Not good! And I2C_M_NOSTART is also out
of the question with this hardware.


--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIbBAEBAgAGBQJTZ7OPAAoJEBQN5MwUoCm2o68P9j2zokQiV9ZjXK9FTh+N8Ikz
URsgnOBtv8YLYksv0Ah/9qp6p1JVVqb9czlkVyp3UA84FffwmNeNM66MOZqr9MrV
FMe4IO+fWFBlWYAbYnW7X625mFyZsvW0+KbpfFyJA2dUPCFa8qL7PzwEYSQNLCtI
StjMwQilcbc8Vf8tbMEY4yNBa1LSEdn50bmLVLYWlPn2jcWRVmyqyfp41wFMJq8F
AtIlvb+cEhXQX+vGXu3J58hTYtc0BWSDU/JmehtW1+B32E2m3TrbBmSfMAaJBsxf
fIWPqDYKxowCN8rA6B4boed5ElbF6XtWJjlTXWYH12Lj3bJFTlefswsWeaBb24Cm
xWCwRYdSn9oD8CHNJrZXqOxTkiw8YaKrCJrPWgKQiSAIPj0hcbbp1RarmnFJHa4Y
9ywT/TkC6vu2CbTEc2AQ4BYmuEAvO/6Q5rBWy/0owg9j0bqi/xSmLzDY9xAYlhx/
pKQJyoSkIddYCKRzIOjfvbW0mTaeBS0tvms2vx6gJQZOoeFkFDFFYPit24m3PMR6
oqAv9Hp1xapTAAd9KyA6A/l6ydqNRv1HNuwyZdfa1VWXOqxg3Ojy67Ma1iHg6CtV
ZFY/n0YS6bfrL8VNUUWzp4qvdQRsXXuyfb+xN/HrQ+H1JWbLAqUpxZtd2wCj/hgX
Dd/QLOzAzINC9iZtsYs=
=rTJh
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
