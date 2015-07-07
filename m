From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 07 Jul 2015 09:17:58 +0000
Subject: Re: [PATCH 2/5] i2c: emev2: add binding documentation
Message-Id: <20150707091758.GF1532@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Zi0sgQQBxRFxMTsj"
List-Id: <linux-sh.vger.kernel.org>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
 <1436219188-4325-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdU1iEn+38FY2ncDL_L_k2ytJFWH+Ek=kF42pC4pdsuAzQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU1iEn+38FY2ncDL_L_k2ytJFWH+Ek=kF42pC4pdsuAzQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2015 at 10:41:37AM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Mon, Jul 6, 2015 at 11:46 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-emev2.txt b/Docu=
mentation/devicetree/bindings/i2c/i2c-emev2.txt
> > new file mode 100644
> > index 00000000000000..a6740066835056
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-emev2.txt
> > @@ -0,0 +1,22 @@
> > +Device tree configuration for Renesas EMEV2 IIC driver
> > +
> > +Required properties:
> > +- compatible      : "renesas,iic-<soctype>". "renesas,iic-emev2" as fa=
llback
>=20
> What's the "<soctype>"? Isn't that "emev2"?

Hmm, I though emev2 was the family but looking again I might be wrong.
But it is still confusing to me. EM (EMMA Mobile) is the family and EV2
is the SoC? I should probably just skip the <soctype> thing above, then
it should be good.

> > +               interrupts =3D <0 32 IRQ_TYPE_EDGE_RISING>;
>=20
> Are you sure about rising edge? All other emev2 interrupts are
> IRQ_TYPE_LEVEL_HIGH.

Yes. R19UH00356EJ0800_1chip.pdf, chapter 7.1.1

64
 IIC0
 IIC0_INT
 IIC #0 interrupt
 Edge
65
 IIC1
 IIC1_INT
 IIC #1 interrupt
 Edge

Thanks,

   Wolfram


--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVm5lGAAoJEBQN5MwUoCm2ZdEP/0/qGMVSvIXd9zsFO6sK+zrF
ROXRaJ4Sbj1aVv+stTsn9f5NSTbMrpNFX2aQJnPnhGgx5Y3drOmwMHHVULkaNaSI
JcH32yjv/Yskli1RxnykKELymuJRSHFth4xganxx7ZzoLMe87ZmyHIkndXlyToOM
oQV6kI9fcGbDhIYwWM6F+OxnsGG3tOdPMz4z6NFxHcWMf2XhkzWSyUk3GIIgZbvr
eFy6BvDSG2i2YDSrZWKeSskHACMsT5b8xWM2NYBAxcFE3ntgYW5XTEOxQMbCFHro
pLEu0uHh4M0zOTeMAQPY29UWME899eL9xUVKnYtspophm5L72Ng7M/EL4jmCG4qZ
ibs8sXCARQ1uHIp1ciHMmmlok6oRfqtjvjNHCf2YOUx55GPzPFQk1jqrZFVYtrgy
q9Q26FFlJ/DJAZ9DY2r9sFapbf1HulMEhNnFzz1PSElTIU2x8na73L/kYkNubzJd
ks+CTVv3zAbO2AqM4Gz2iAraMgLxeJyRgtP8IzDz0CzEuu67Lp72IQgJw5/2ewu3
4W19vXGux1+sqIWd1MyE3HmdT/8c5SsvlZZAa/UoKFE2ifjXuYRXe1XfXsRLaL5c
rQJ+A3yTuhutXpel4LDouM6Uas9yqOWSduNudQdgPavaR1/0wmoWSlYH6A4LhUhu
4a9lExzesLG0PZ8p0CpX
=YLDz
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
