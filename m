From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 20 Dec 2013 15:47:46 +0000
Subject: Re: [PATCH V2 5/5] i2c: riic: add driver
Message-Id: <20131220154746.GA9017@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
List-Id: <linux-sh.vger.kernel.org>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1407973.m5fTNuo5v5@avalon> <20131219120646.GA2563@katana>
 <2069590.SA4Ef3s3BZ@avalon>
In-Reply-To: <2069590.SA4Ef3s3BZ@avalon>
To: linux-arm-kernel@lists.infradead.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> disable interrupts at runtime and use that as a state machine, while I wa=
s=20
> wondering whether it wouldn't be simpler to keep all interrupts enabled a=
t all=20
> time and handle the synchronization explicitly.

If I do this, I'll get another "spurious" interrupt telling me the transmit
register is empty again, even after I wrote the last byte. I don't like
this.


--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJStGaiAAoJEBQN5MwUoCm2DcYP/3z9GjJp6JmRkc0tYIIGkEzq
iZgFWxgcfcBN/2sJa7HRTEjJG13QNwc9VJuJn5UBuo9lGoml5l0AIR0ehseRckfP
+caRENFdLAGZs/1G3hnviRG63ApX69iZ7xMW2HB3AhtKzv3m79llHtAxMKjCYiMW
O4nhVqh/4aCMchpTebFK/ltb+BnFrCGp2MqCADDaF5rbQiDlA44ErdAiKnJgSakF
BXx168diQFNDoVjT8Zt7f8LzEdN019NZslmnE5kaG6un8gx8eiDkoSZSCZ/6Ytsx
EHCEp8tXL8Q31Covj524ypavXJesjcZvwt2ILR1jLweBLrItpjLB7VxehWHxDray
MjC4pIwnaLdy2Hq7VPz+bx67p2x8HZcL4O7rBThx4EkBDIciPp42f/IFQhOQok0e
u23uX23H9SNhUOAdtUnId84yD1Ankftr9sNTIsY5Se8OXmxZhQvPHxe8FiZ/v7MN
p3n2yclxp5Tcclz37D3kq4PNikTXIfldMRutjf3m8Ml1AgxYrPtjeQaJZIUPQIEB
rtEWXt3V8a1FfAnkzIoorsZuQhBcXRvxABnLnESufzJ1sCZFLoDXWprlu1rsEScc
PVDykU7dNivn7naHFmT+7wzsSs+X2lQG8M2rEfJLjZZ5SJVym3RK+GRtsRcncikh
0M+s3tJMwNsUrVkAn+4p
=qgR1
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
