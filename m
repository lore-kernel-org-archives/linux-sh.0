From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 06 Jan 2014 06:50:06 +0000
Subject: Fw: linux-next: manual merge of the sh tree with the  tree
Message-Id: <20140106175006.12e983b2fcc905d72b85d2a8@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__6_Jan_2014_17_50_06_+1100_U8sD5F9nam.afhSb"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--Signature=_Mon__6_Jan_2014_17_50_06_+1100_U8sD5F9nam.afhSb
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I sent the blow message earlier today but it bounced with:

<lethal@linux-sh.org>: host mail.linux-sh.org[111.68.239.195] said: 550 5.7=
.1
    <lethal@linux-sh.org>... Relaying denied. Proper authentication require=
d.
    (in reply to RCPT TO command)

Hopefully someone on this list can contact Paul ...

Begin forwarded message:

Date: Mon, 6 Jan 2014 12:13:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>, Arnd=
 Bergmann <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Bastian Hecht=
 <hechtb@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboar=
d.com>
Subject: linux-next: manual merge of the sh tree with the  tree


Hi Paul,

Today's linux-next merge of the sh tree got conflicts in
drivers/tty/serial/sh-sci.c and include/linux/serial_sci.h between
commits 8fb9631c517b ("serial: sh-sci: Sort headers alphabetically"),
20bdcab8268c ("serial: sh-sci: Add OF support") and probably others from
the arm-soc tree and commits ada80ee7fa60 ("serial: sh-sci: Add OF
support") and b19ef75c56e9 ("serial: sh-sci: OF definitions need
linux/of.h") from the sh tree.

The arm-soc tree version is dated much more recently than
the sh tree version and conflicts badly, so for today I have just dropped
the sh tree (everything in there was committed before April 2013).  Please
figure this out.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__6_Jan_2014_17_50_06_+1100_U8sD5F9nam.afhSb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSylInAAoJEMDTa8Ir7ZwV56AP/jWpWBZDsfAGAR355UtY1yQt
ivNr99qRTUH7/+IwIuCYTwsFwiQKn10wIMQ9YbkJOyhP1CPNfjedBNlpsu9OrrCx
Eh4KUPN0BSxAiSb085NxWCRBR0bHAnMq1P9Qu4J2LI22s2/ggx+KR9t2DqcKGTOn
MfJv9iYhXzDc5luNU9BzCFc+udtlnixRRmxgctQfmAxHczPvrpneGeUuBaRMtDnF
LoY5TBKZH6keGFAd9l8Eq4LlmjL3UdbMNAC/FkVn8phMXdtJ0XUvDKxRmYyj0SIa
TAPPs2KQwCJt7ObO7KJ7ekmUqUNh0ChndSQSz6V1H+rv/q0rQjTAjAgFR0GOoO3U
pTi9/HgEHWBcIfbt2Gjfs+hZMraP0dPEtF5ddHtGE3mbXqjege7rMFcjOaSMK534
TAhXT9lpaUz27XEPOs5VqE6JqLNGk0di1aMVuh0DOHp8NvVl5ysXSEf2T8ZjOGfx
IQGxVojRCgkQOKkmKwEqZTRit5N2xVcNaHxEno6CdjhL9ENCWjaMkprkY1bNmTA8
WetVdmV5phQMat8xHfyXHTX/zvBKbxs/GxQBvrDfrwzXiSMP1X5+l3bw3nLZelxQ
N4/XXB6ytIPz3OExPUsFBopINPRe4q7i1wdvuvKV2qIRgcESo1AcbE97UkZcUKLt
9MejYZ5747yxT73sgnpL
=yEWI
-----END PGP SIGNATURE-----

--Signature=_Mon__6_Jan_2014_17_50_06_+1100_U8sD5F9nam.afhSb--
