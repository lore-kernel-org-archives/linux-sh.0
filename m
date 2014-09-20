From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Sep 2014 09:41:05 +0000
Subject: Re: [PATCH v2 1/3] i2c-rcar: simplify check for last message
Message-Id: <20140920094104.GH1612@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="82evfD9Ogz2JrdWZ"
List-Id: <linux-sh.vger.kernel.org>
References: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
 <1757193.42K2JNstnx@wasted.cogentembedded.com>
In-Reply-To: <1757193.42K2JNstnx@wasted.cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2014 at 12:14:14AM +0400, Sergei Shtylyov wrote:
> rcar_i2c_master_xfer() needlessly compares the message pointers (using in=
direct
> addressing) in order to detect the last I2C message, while it's enough to=
 only
> compare the message indexes.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20

Applied to for-next, thanks!


--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHUuwAAoJEBQN5MwUoCm2rOcP/Att0G4hfrgBmKRzuXLavEzH
S5c34La/PHKjiEXY7s259Q/wDMfkMlAQl2h4kbl1YjNJlZX7S71+4TDQqGy7MAgT
01XEyi1kwyl/5mRngH9vxS2IGHYkZ7lPg47BHp7ISdZPuC5C2sf/XHQzF4mBel+O
voyz2rOV6cH6te/RcSUR3Hqtrj4H/3/K/pdIvFtEqiubycPfcXfx09wVGllGjzr9
v57hVYgtYRPywqSrDnpweS9tgMmw/HpGDM1nwnKE/oMUb08YVPk0Ovf8iom/X2A3
jqiQN4w/tYmwm3S9oCVsJSnEIn5VX8fGNWU/h2LKBcm2/qPydNHWNIa22SC5zt6J
QSFh3hJ9JFSjHQLv6be0YX2C9dKHkxYPEe3I/NktELw2pUnqr4QqxQDgBjVSoNuW
uWEvtczV/MkEN092CcdWwIJBwJPoIEZ6P5Cu2OCScBiAi5ySV3dzox6iNrXZsiws
igAVb9DhVDgsqS4CGbtBVfTKucSVGmSbTZZebBxzS9EPJBCHr7h3j+UUZqHJKnPM
JIg5lUKaY34dfnSIbTe5mZLPhRUyX8bwDeKG9vCHbK9mmgPyHCNQCH9Lxo9TrYVl
i7AOFVu3TLH62qvScrkaaTFaCVUXv/n+FFrQOXCW0Ix/wHRrgUo8iXEJyLQ0ULVm
apOm4fcBDmFaR/hGs+31
=s7rV
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
