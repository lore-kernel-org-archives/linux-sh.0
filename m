From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 10 Jul 2014 15:42:13 +0000
Subject: Re: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <1789172.89NshR7Suv@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart16732442.ISvDbrEf1N"
List-Id: <linux-sh.vger.kernel.org>
References: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--nextPart16732442.ISvDbrEf1N
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Vinod,

On Thursday 10 July 2014 20:39:29 Vinod Koul wrote:
> On Thu, Jul 10, 2014 at 02:25:58PM +0200, Laurent Pinchart wrote:
> > On Thursday 03 July 2014 10:48:34 Wolfram Sang wrote:
> > > Hi,
> > >=20
> > > > With dynamic debug, these flags dont make much sense unless you=
 want
> > > > something to be printed *always* during boot.
> > >=20
> > > Yes, this was exactly what I wanted.
> >=20
> > Why is that ? My understanding is that the purpose of the
> > CONFIG_DMADEVICES_DEBUG option is to enable debug messages for debu=
gging.
> > As it requires recompiling the kernel, wouldn't dynamic printk be a=

> > better alternative ?
>=20
> No it wont. Pls see the discussion.
>=20
> Lots of dmanegine device gets used at boot, so for testing those scen=
arios
> it will help to enable debug!

OK, that's the point I've missed. I agree with the patch then.

=2D-=20
Regards,

Laurent Pinchart

--nextPart16732442.ISvDbrEf1N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTvrRcAAoJEIkPb2GL7hl1a94IAKb7Yp2s1Ua0M8EArnvykIJ5
va/3kBR2bgyJmhVBBKUh0D+kjm5o2nT5p8QRZByKks27B1isVYed5ZtNnPyeNEMb
p2BPVTgj5yiZzG+w10uE/bDQKqGyZqJzHMEmRRaDJzX81fy2qppLlvRYOSyjjQ4m
KWj1dRJcnabYsZorQHB536KmKoPOOT/tJks0FXVGQ2a/5zrc2a3MM4eT+6QELdEW
zyzbz2wDktUmJlDsO538pJ0zI5qkQTyFBPTqr43VVob8+wtqaw353Iobmcd0IpML
L80W5Wd+eA5msufGpCll3vVCiz0JmM8B2YWfuhuMG1LcmzBUmi26DbqPvT5nxHw=
=ANBy
-----END PGP SIGNATURE-----

--nextPart16732442.ISvDbrEf1N--

