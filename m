From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 11 Jun 2014 18:51:41 +0000
Subject: Re: [alsa-devel] "ak" vs "asahi-kasei"
Message-Id: <5398A53D.3020706@wwwdotorg.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="80sFXI81mq8kphumoKnapshmF3u2sn5GF"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com> <87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com> <539815E6.2050304@codethink.co.uk> <20140611165410.GK5099@sirena.org.uk> <CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com> <20140611170233.GL5099@sirena.org.uk>
In-Reply-To: <20140611170233.GL5099@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--80sFXI81mq8kphumoKnapshmF3u2sn5GF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/11/2014 11:02 AM, Mark Brown wrote:
> On Wed, Jun 11, 2014 at 06:57:44PM +0200, Geert Uytterhoeven wrote:
>> On Wed, Jun 11, 2014 at 6:54 PM, Mark Brown <broonie@kernel.org> wrote=
:
>=20
>>> They're usually referred to as AKM when abbreviated and their web sit=
e
>>> is http://www.akm.com/ - don't know what the stock ticker symbol is. =
 In
>>> any case there's no real cost to adding both abbreviated and
>>> non-abbreviated forms if we want to transition.
>=20
>>     of: Add vendor prefix for Asahi Kasei Corp.
>=20
>>     Their stock ticker is 3407.T which wouldn't make a good DT vendor
>>     prefix. Use the company name initials instead.
>=20
> Sounds like akm, is a better bet then, especially as ak, has no real
> adoption. =20
>=20
> I think the bikeshed would be much better painted pink with yellow spot=
s :)

Sorry to jump in on this late, but what on earth is wrong with "ak". It
went through the appropriate review process, and is already in use.
Admittedly only in a single ARM DT file, but it's still in use. We'll
have to allow the ak prefix forever given that DT is an ABI, so rather
than introducing more random variations, we should just stick with what
we have.


--80sFXI81mq8kphumoKnapshmF3u2sn5GF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTmKU9AAoJEJuNpwkmVCGcz6IQAKYPXIxhgnWLoPOk1gGoHvEc
A7ds6CfeZynIseXt/s42IqvOY3cFwUYTrnN/2h2YN3ubQx48JFNdqsAfx6FgwJwx
HjxfXRe7ntYthiWsuf/WPuRD4FVx+LFeQHQLk6b31kDV5IwGznwgKNfmSlyVj91I
hg7ra5xvbYVoAZA6cMC2gEpCvWsWmDhKQ+GWvtNUd4OO4I5sLnT2rQkn5YKDWYVB
ZAEQem3sedruxUFK0SCychwAVSF/OAqrz1vhjpZIyCCM8KIPSJ5qOId1M1RXUg4q
fCR1lSWqCuBwBXnCV7p0wBkCSJYjDSmpZEeGimwv4tihWtALI7eb6PObHq88mCF/
/y03NttD1wdNcGysocLWRvu3IQbXtlTnCga328W49BLMONzfIIMdVpz1mbAtwKZA
CKKrvVgz4A8ezuNPDfNDGGH/s1Qi49PpiYxEWpapIV8R4+rrnaXM2sLGKOI0IVt3
smmOVnuI5WpF3deRn3lA45f7n+RY53BzHQox0LIppgRKkvSDDcZQMH4Sp9BgZY4s
4Kvkvd50atYq8Sgb5L1PQ4YFH3EFuUfvGR30UtEtWCgbE6+/uoIOj4U7ZG4FfvDK
pPrjdEjxQ5WpCX1UVkS7D3J2PuiQNqbkPSgEwh77tMuGHNRrpVduzvv9i/maeAKw
YUEq+83TtVlPF3CrhpG/
=oNZD
-----END PGP SIGNATURE-----

--80sFXI81mq8kphumoKnapshmF3u2sn5GF--
