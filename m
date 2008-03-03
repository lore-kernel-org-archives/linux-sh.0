From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Date: Mon, 03 Mar 2008 14:01:56 +0000
Subject: Re: MTD types
Message-Id: <20080303140155.GA17732@lazybastard.org>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60803021219k23ca6c6bt2ce2fb2c61cda42e@mail.gmail.com>
In-Reply-To: <8b67d60803021219k23ca6c6bt2ce2fb2c61cda42e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Adrian McMenamin <lkmladrian@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, dwmw2@infradead.org, linux-sh <linux-sh@vger.kernel.org>

On Sun, 2 March 2008 20:19:09 +0000, Adrian McMenamin wrote:
>=20
> I am loathe to just post a patch adding it back, so does it make any
> difference if I use another type (I really have no idea of what the
> physical type used in the Dreamcast is, though possibly someone here
> might?)

There is also a bit of confusion about what any specific time should
_mean_.  Once upon a time NAND flash had ECC, could be written only once
(i.e. not write single bits by cleverly masking and rewriting), had a
well-known amount of OOB for general use, etc. while NOR could be
written bit-by-bit, rewritten, did not have ECC, had a higher quality
and all that.

These days you can buy NOR flashes that have all attributes of NAND
except OOB, NAND flashes may use all OOB area for error correction, etc.
etc.  In short, there is just about nothing left you can use the type
for.  And when it is used in JFFS2, you will find lots of code like "if
it is this type, but not that exception, then...".

J=C3=B6rn

--=20
"Translations are and will always be problematic. They inflict violence
upon two languages." (translation from German)
