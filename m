From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 May 2014 13:44:56 +0000
Subject: Re: [PATCH 1/2] regulator: gpio-regulator: Add required regulator-type property
Message-Id: <1885616.D9TNdZVfuO@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1818049.ItSK0xXosh"
List-Id: <linux-sh.vger.kernel.org>
References: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2193707.R9XiqBsnU4@avalon> <20140513165921.GK12304@sirena.org.uk>
In-Reply-To: <20140513165921.GK12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org


--nextPart1818049.ItSK0xXosh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tuesday 13 May 2014 17:59:21 Mark Brown wrote:
> On Tue, May 13, 2014 at 02:06:23AM +0200, Laurent Pinchart wrote:
> > What's the status of this ? The gpio regulator driver now defaults =
to
> > voltage regulator when the regulator-type property is not set. Shou=
ld the
> > DT bindings document the property as optional (I can submit a patch=
 for
> > that), or do you consider that the gpio regulator driver should sup=
port
> > voltage regulators only when used with DT, and just keep the
> > regulator-type property support in the driver for backward compatib=
ility
> > ?
>=20
> I don't really care either way, I did write a patch for the bindings =
but
> there was some language lawyering over it and I never cared enough to=

> get round to updating it.

Could you please point me to the patch ?

=2D-=20
Regards,

Laurent Pinchart

--nextPart1818049.ItSK0xXosh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTfK3dAAoJEIkPb2GL7hl1oA4IALQEal7dcRGY5e5H3z+MJtga
rPmqakhShuJEFlR2qSgUtdKlvF9cs28o8XLIF0w8Yzp8KmuJwgCYhRXlm9pmFKvW
k428y2vHWUOelJmmFvse9nfvgcDHb0UQ9+Ky9igsqzMcYmuR9mVkzqa8MX7hcimQ
8G8pRmtec7W7Z7F+7lwv/AON9Bs+fC1Fh6rKnq9UokdIQqo7dF0ok1M/O/tbnC1K
wrSO2gMe2DoaAxnB84S0ygUGvTbq+h4Bt11r6zInLRVfN0cLffGf+udeixWjqxMb
OYN1EKgpNaz/3vjpIgChJjv2IoeZbPwwGzSpnioMIs8aJFJ4tIqmtyqoX5Yd4MA=
=4vxS
-----END PGP SIGNATURE-----

--nextPart1818049.ItSK0xXosh--

