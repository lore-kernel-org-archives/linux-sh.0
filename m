From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 12 Sep 2014 12:15:10 +0000
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Message-Id: <20140912121510.GD1930@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BI5RvnYi6R4T2M87"
List-Id: <linux-sh.vger.kernel.org>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <7627175.tG5quZH0VN@fb07-iapwap2> <20140912095821.GB1930@katana>
 <1921859.32moD2F04k@fb07-iapwap2>
In-Reply-To: <1921859.32moD2F04k@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Am I missing something? Board properties can be encoded within the
> > compatible entries ("ax100-ec", "ax200-ec"...). I'd think this means
> > mostly different protocols, though.
>=20
> well, ac100 is the name of the board and nvec is the name of the protocol=
=2E=20

Yes, the driver could be named nvec, yet the compatible-strings should
be similar to above. From that, the driver can deduce the protocol
variant and possible initial settings.


--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEuPOAAoJEBQN5MwUoCm2+CQP/2133fSsmcvel6AnjbBLnA1b
WlICrWzG2ZpamkzbU2pGwQMgQ0mSfOTIHQaZmOqIJQAxz3zVGYYatLlXYEzn9qDw
XjNcHR81TGM+IoM5y3/02Yt8DEbGmqo7fiUIL/unzgjSlggyWfN+00MDOdTlvXfa
FkBbfc0drTK3xmxeK4fot5vBty/oNDe75nlB+GgLhj6QysPBWwMk5DCpwR54R50K
N/uMIj8TiAQHlng7BuoA9C7NkPAEZ1NqYI9rQJHKIN7GybZZNbtfDistL+uYog0q
KjxS4BcSL3rha2O2i4ATOUG8URBGJi5Dct7GwWGo4jkDV+Du5lYejBL+HQ2GDmdv
BtqklKnWynlx0+d4NBN6y9/EqM9h4eL5njzfuiCaMIHX9XfLLgxcOClSYt73GpVo
GH2IgpxAHY8u4g0ARXZRJKsfFQPWhfkWYMo/PnfHpTNbQ8HzcU9fptCo9q5fPw4V
bOid0iOYxIWXUhqyAS+AVawBQpaw9u0XGxYuks3/GJyvt6FCd/pZDn/j6Daqv90Y
TQrGrueOHgLjw38DiTm0cU+EeuSjqSQB10UDzu0ZW6LdLIm4hGtJc7XpaYUdzBY0
CXUlyY1tch4a+N035jYQZ637U1SJ2D/HmFdkMfS4V46WzZKxmOsNcDzjpyt4sf10
fI3Krrcbh9NsXRUEFkhI
=BXAr
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
