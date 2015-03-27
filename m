From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 27 Mar 2015 13:11:04 +0000
Subject: Re: [PATCH/RFC] i2c: rcar: Support ACK by HW auto restart after NACK
Message-Id: <20150327131104.GC19151@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WfZ7S8PLGjBY9Voh"
List-Id: <linux-sh.vger.kernel.org>
References: <1424011480-3551-1-git-send-email-ykaneko0929@gmail.com>
 <2775fbb6b2e2b333ef2457133f419d4d@the-dreams.de>
 <20150304040635.GA12776@verge.net.au>
 <20150306221809.GB6572@katana>
In-Reply-To: <20150306221809.GB6572@katana>
To: Simon Horman <horms@verge.net.au>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-i2c@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 11:18:09PM +0100, Wolfram Sang wrote:
>=20
> > > >Even if R-Car I2C received NACK, after that it might receive ACK
> > > >by HW auto restart. In case of that, driver would continue process.
> > > >If R-Car I2C didn't receive ACK, the driver would detect timeout
> > > >and would report NACK as -ENXIO.
> > > >
> > > >Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > > >Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > >=20
> > > Excuse me, but what exactly is HW auto restart in this case? Is it a =
feature
> > > of the I2C slave?
> >=20
> > I asked Kataoka-san about this and his response was as follows:
> >=20
> >     It is a feature of the i2c-rcar(H/W) master.
> >=20
> >     If system(CPU) is busy, NACK procedure may have interrupt latency.
> >     Since the clear of ICMCR.ESG bit is delayed, i2c-rcar(H/W) may auto=
-restart
> >     after NACK. Please refer to ESG bit of H/W UM section 55.3.5.
> >=20
> >     For example, this is I2C write transmitting.
> >     1.Start / 2.SlaveAddr,ACK / 3.RegAddr,ACK / 4.RegData,ACK / 5.Stop
> >=20
> >     If No.2 has NACK and interruption has delay, this transmitting is a=
s follows.
> >     1.Start / 2.SlaveAddr,NACK/ 1x.auto-restart / 2x.SlaveAddr,ACK
> >                                     / 3.RegAddr,ACK / 4.RegData,ACK / 5=
=2EStop
> >=20
> >     NACK of No.2 is invalidated by ACK of No.2x. It means recover.
>=20
> Does this make some I2C device work which did not work before?
>=20
> Most I2C devices always ack their address, so NACK very often means
> "nothing is there". I think it makes sense that the rcar driver returns
> ENXIO in this case which is documented to be used for NACK after address
> phase. Then, the i2c client driver should know if this means "not there"
> or "currently busy". And it should know when is a good time for another
> try. As I read the patch, the driver would use the auto-restart feature
> until the timeout is reached. That would make bus scanning pretty slow,
> too.

Hi,

any news on this one?

Kind regards,

   Wolfram


--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFVboAAoJEBQN5MwUoCm2CdYP/RnIHbgdXtM+4HZz8ANuE/pM
sUU83iZ52v9Us3yXjiCfwQ48S17KCp3uU5f8ayQxakuf+Iey2PFi0dh1hkdIwgC/
HsVokSw1uhzKMKwW6TX7cr66LTVV1l+F/HMJyAlBKiVYtthaL91x0g8HxUQlrSWS
VYVfcPQgea0eLTL5ai5r0zLs2IJdS6N9S+fp+hUtsqLYZvZdV3uwYkcyqLWCbBMo
G/BqvENQAAO7g3KalCLujrr4sEEMESP7e5HWIdzfby0Xe0My6/TxhnvX8MMEuaI4
UozP44LQTy6fEXfdESKKLb/Ncb91s8r+2dOBBHkfripUNh39ywTmZC8nRptZiAm3
QPs87+EdwuhMrLliDDYXcoDPNvM0IgQfj3mof4zC8tCd9d6rkGGkubkqwHTHNA5e
DlNa+KSpLOcH2sdMDl+CXtk/G5chGx89VY0OgnyllPyjXpIzZUtGuaZK23rTswIJ
VKt+6vPWG4v8/MiHCLIIicwTYXes6z3zZUCez3CgkN5n3D0bqQpA4mKucoyNIWly
1VLBRqGUuPLhGPkFpxwIVwDEaPJj0fYmfkTkoC0aKyy74z4IxIAqeetKGv9NemxA
j+/+epC52PhIX03ixFM0uAwOKmN12fwPgJFwbnicrtTS40pc7mppg9cN0Pw5eSQ/
WHYUaEckVsfTr3qKAMxJ
=+1iX
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
