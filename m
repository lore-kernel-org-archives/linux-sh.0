From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 02 May 2014 07:19:31 +0000
Subject: Re: [PATCH 2/6] i2c: sh_mobile: improve error handling
Message-Id: <20140502071931.GA2647@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
List-Id: <linux-sh.vger.kernel.org>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
 <1398896470-24663-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdWs=FkAgCpBNQcaRtJRanGQjp1erN+=Jqpekioj+9pk1A@mail.gmail.com>
In-Reply-To: <CAMuHMdWs=FkAgCpBNQcaRtJRanGQjp1erN+=Jqpekioj+9pk1A@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 12:25:38AM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Thu, May 1, 2014 at 12:21 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > Use standard i2c error codes for i2c failures. Also, don't print
> > something on timeout since it happens regularly with i2c. Simplify some,
> > logic, too.
>=20
> You may want to keep the timeout messages with dev_dbg()?

Not really. We now have an I2C tracer which shows the return value of
the transfer. I really want to reduce debug output of all drivers in
favor of the tracer.


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTY0cDAAoJEBQN5MwUoCm2yMAQAKM5PeO/Cxh1CbuRHzc/Mebm
a7qpGhQm4VOKulkiYGSgcDNQafHCz4sEWjDO6PYXX+Uk8v0rmwB/TAwhuQM75Zau
bKmyXHfF2cvrsV+OzbuZ7YscM9aOSTZx//KaN1DtLUjnTltJospU4H5dJQ4JRtAQ
f2wCRSg91aTNN9/fr3NlLXp8Hhga+WA66y+6Ip9nU/f5V/IwW1mgg68FUdSnaeKY
MCKTu9JbYtCN6BfUKeh4PbyxOGD4Ix0EKT4a9Yjz8jvNmZG6IbHxe5MPUVUOv6hz
JRYJFjChf8RU0sX/Mj6J9NOfMIHBGgn7b0wYSBGk/IAGUeiE/1IO2Y2uAmprrkd/
7p+3+KWKQLqWY3g5AJjsqGAmpCfCAIPMeqQGyG/jpG8nD7Uw5pNaUwDq04Wy6pEn
NFYL410/VdueofRQIgoKiPcsu4ZcMsyJ/UfXne/GEuIWxEUASA2vsODBlPURV4cL
lPXyR1gozOXyz+WFn91kwX6JW6TieEcxZlk6e0sr16/kDLAlEy/kloeSiecS7BqL
KhHWpMvKWizOH0WWXXnUHyw168Iqs+ibf42FzcMmSqJjNds5QVGKqBzvTuSTWK/L
Xr1PnwmbzDSwvpTFQlK1g11AJBwI1SPNWoPKXWLx6UM5LGE17Mv7RF3B42OWw09G
s0h81k45FZyThQU+t7MR
=nakb
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
