From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Jun 2014 21:42:26 +0000
Subject: Re: [alsa-devel] r8a7790 only has audio when clock is forced on
Message-Id: <20140603214226.GA2520@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
List-Id: <linux-sh.vger.kernel.org>
References: <538E0487.1010700@codethink.co.uk>
In-Reply-To: <538E0487.1010700@codethink.co.uk>
To: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>
Cc: linux-sh@vger.kernel.org, linux-kernel@lists.codethink.co.uk, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2014 at 06:23:19PM +0100, Violeta Menendez Gonzalez wrote:
> Hi all,
>=20
> We have a problem where audio on r8a7790 is not working due to it not
> sending interrupts.

Adding Morimoto-san who does most of the work on those drivers upstream
- it's always best to CC relevant maintainers/developers on kernel stuff
as things only on the lists are easily missed.  Not deleting context so
he sees it.

> We've verified that the pins and the clocks are working and correctly
> configured. The codec is starting and producing correct bit and word clock
> signals
>=20
> We've made a hack to force /mstp10_clks /on that makes the audio work.
> Further investigation showed that it's only needed to force SSI(ALL) on,
> but, as far as we know, the manual doesn't say anything about it having to
> be kept on.
>=20
> We've also debugged this hack and saw that the registers have correct
> values. These are some of the debugging messages we have when the audio
> fails:
>=20
>=20
> Playing WAVE '../audio/r.wav' : Signed 16 bit Little Endian, Rate 44100 H=
z,
> Stereo
> cpg_mstp_clock_endisable: index 5, enable 1
> cpg_mstp_clock_endisable: index 5, value read from group->smstpcr 0002ffe0
> cpg_mstp_clock_endisable: index 5, value write in group->smstpcr 0002ffc0
> cpg_mstp_clock_endisable: index 15, enable 1
> cpg_mstp_clock_endisable: index 15, value read from group->smstpcr 0002ff=
c0
> cpg_mstp_clock_endisable: index 15, value written in group->smstpcr 00027=
fc0
> aplay: pcm_writecpg_mstp_clock_endisable: index 15, enable 0
> cpg_mstp_clock_endisable: index 15, value read from group->smstpcr 00027f=
c0
> cpg_mstp_clock_endisable: index 15, value write in group->smstpcr 0002ffc0
> :1710: write errcpg_mstp_clock_endisable: index 5, enable 0
> cpg_mstp_clock_endisable: index 5, value read from group->smstpcr 0002ffc0
> cpg_mstp_clock_endisable: index 5, value write in group->smstpcr 0002ffe0
> or: Input/output error
>=20
> This shows that the SSI (ALL) clock in bit 5 being enabled before the SSI0
> and that it is also disabled in the reverse sequence as expected.
>=20
> Not sure what to do next or what the problem could be.
> Any new ideas are welcome,
>=20
> Thanks!
>=20
> --=20
> Violeta Men=E9ndez Gonz=E1lez	http://www.codethink.co.uk/
> Software Engineer		Codethink - Providing Genius
>=20
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>=20

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjkE4AAoJELSic+t+oim9Zb4P+wf053OLqooQ3AJ4C+nxjeZt
9rvPr0WlKxUvca3bB6/xTjHrQKtmZ9kDW1a9Yb4wfIDnJJfym/Hxjj3iJhZUpVSi
m91n8cVk0yhldToQlxWVVdACeANWkwycypp3Q/7zF5kQbvZcSVeW25kQZVa3kdze
/xWMUyTR/EMO8G0mKQ7P3maPaOa/kh3dRdccgZzgtvuYjIVCtYyss4xBEOfj5OAt
N/hLEeiJOCp+sPVvP4aCU5CRetpHhkV6SJR42UL0xEA7utH0+0TlCcusdO7h/+X3
SzbKcGn+Cui739KdR9lj8cehrnDBaNaPDeDKiBvO+frBNL94vkKeDuJ/IKqliJDQ
a1WRkbah4+GhNv58UHD8CbNQSRGLYu+5JS4vpN+PiRVDbG6KJBegXY8XgsKcdVNb
5/OTdOjZPurY2Mf8Zm9P8otL6ESSHTCJ/yjx9iGD2Y3sjexs6X7/+LJV4C/Pb3P1
yY65gCw6e2ftiNlTsTG6J1DWx7O9zqKUp3iF2BbAfKKU/o1FW6G9vPl7bm1L9OYt
6wrBryHF+QY+7WEFUgfoCRVUZc9wTa1So3Xe0V72avLb4Ro3+r0JgKNTRAsCUhKq
C2USeDNx+ZJyr42eJytkIb5tFm+ar3L0sUej+I2XjmAVew9ugLbAzyyyfrr0Br5c
k75vwHMbK9BueIyMmKdr
=zB70
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
