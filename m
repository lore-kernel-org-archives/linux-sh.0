From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 03 Jul 2014 09:14:25 +0000
Subject: Re: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <20140703090225.GM2296@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="/NkBOFFp2J2Af1nK"
List-Id: <linux-sh.vger.kernel.org>
References: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 10:48:34AM +0200, Wolfram Sang wrote:
> Hi,
>=20
> > With dynamic debug, these flags dont make much sense unless you want so=
mething
> > to be printed *always* during boot.
>=20
> Yes, this was exactly what I wanted. So, for consistency reasons I
> copied the existing mechanism over to sh. If it turns out that the
> desired default is something different, I'll send patches for that.

Ah good, and while at it, Please *do* mention this in changelog!

also fix the subsystem name to dmaengine in patch title

--=20
~Vinod

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTtRwhAAoJEHwUBw8lI4NH70MQAJ31jolGdQpDOAXs6FUeCXd+
86XOfn3hEf0e/q0Ay/x73p8z+MX2hNLKnrZTCmriSkrNK3TOCMhxj1OCigYmf1+J
NOGQGGFXho3pmvqzHhdX3bJs8919UH6PP9RGlFOX0vAE5iha1CoDBJi0XioGyHQ7
w2fQZGaN7ScV1byE2IRoXyT6cODV2aj8vjqx3MRo8s2xoenDQc4a+piPwTYm3eUm
Y+gQM4F+pvFqduZo1rO5xJGRGN9ETUHdaXAcgZQmMci4k+wi6Dng68orMJJOs4Pu
JfkuKzkrN3LaeTh47WS6blWa4tTqVsNNxzQRncS96wO4pOMDXjEBNQXucq5CGl/w
bjctWXRaFkP8T5I3q08TpbyaR6qCEN+WOOCsVuYch3s9aVS6gb7yIiY99XzU8H8z
RFqZseX4gtwgaMciXS9iW3ORIAyIGvA6PYdMlMFVMQUU2RhQPg5LpODI8sDhxVbD
q2lz+WqtwORHyrK8sSM9oMxirWrp4H244bO01FZTBu2miO2QF2hyKV9rYSvsAOzG
144GDm/mSybB8BtpVdo7wueJCjB1SA2IfOownX6cJONeJe6Dh65Y81ViL9DUQlXh
GYhfY1Zh0kxGlGPXs0UHRdQrDhmGG9ziGD0R3bBlp2/MVjFjZJBjXMLTfez1br5b
9hqnTjzBKPOGOHiSL6+L
=ZA/8
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
