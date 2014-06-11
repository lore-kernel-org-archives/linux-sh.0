From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 11 Jun 2014 19:16:23 +0000
Subject: Re: [alsa-devel] "ak" vs "asahi-kasei"
Message-Id: <5398AB07.4040304@wwwdotorg.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oLu9tqJUAW78NmtAT4sNV7skSPHvI78te"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com> <87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com> <539815E6.2050304@codethink.co.uk> <20140611165410.GK5099@sirena.org.uk> <CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com> <20140611170233.GL5099@sirena.org.uk> <5398A53D.3020706@wwwdotorg.org> <20140611190444.GN5099@sirena.org.uk>
In-Reply-To: <20140611190444.GN5099@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oLu9tqJUAW78NmtAT4sNV7skSPHvI78te
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/11/2014 01:04 PM, Mark Brown wrote:
> On Wed, Jun 11, 2014 at 12:51:41PM -0600, Stephen Warren wrote:
>> On 06/11/2014 11:02 AM, Mark Brown wrote:
>=20
>>> I think the bikeshed would be much better painted pink with yellow sp=
ots :)
>=20
>> Sorry to jump in on this late, but what on earth is wrong with "ak". I=
t
>> went through the appropriate review process, and is already in use.
>> Admittedly only in a single ARM DT file, but it's still in use. We'll
>> have to allow the ak prefix forever given that DT is an ABI, so rather=

>> than introducing more random variations, we should just stick with wha=
t
>> we have.
>=20
> Well, the issue is that in reality the bulk of the drivers are using
> asahi-kasei, we're going to have to churn at least something anyway.  W=
e
> seem to have one in tree user of ak in a DTS file and two DTSs using
> asahi-kasei with seven drivers.

As far as DTs go, there are only 2 users of asahi-kasei, and they were
both added well after the prefix was documented, so those seem like
plain old bugs.

But due to ABIness, perhaps we have to support both ak and asahi-kasei.
I don't think fixing this implies we should introduce a third option akm
though. No DT is using that today.


--oLu9tqJUAW78NmtAT4sNV7skSPHvI78te
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTmKsHAAoJEJuNpwkmVCGcZTMQAItKhARn/wNeYkPSQfdPCnG9
IcWwcG0OQOO9KEHo8NnVRRvW3YMBUHhnvbYIrjV9JAUKFWOt5/4n329xiekyBkFh
3jP0LcgYSAmSSPVsRam3bcAdc73Ma/QF5ptDwxgzTd6uPZUFhm1d+v5GhO8LKBvf
1F5c5uGqemc+jpvD3dFpuoaV+Ojz5rMtMXxe2FkEZ9gz6ED9K7DcqPwfli9n3R7n
60DYXCT9cvKOc2yEcGGQnuJ58nK/rCvSa4xDrHvb/xDzxg4MsnwcKW/axVsyb+KH
a0dn8SGbmGm485SvNPTDA+8DEkzuc34EYRhiyucZrdkam2ARsjq1lGX7eageX1QN
dx6TKNxihj83TNiDagoqXm57xx/BVfPHGND/mwz/ygrE0JtMBuFWhtEsQZhbexuN
7uxu1b9Wu2SmjjEnNwGwK6KdOqtttRjzxw3DKOOpdcVWSFwc6Ut6/vByDeY1pIY3
UQbvfWOBVRfrDaaLx76Mp7azLTpXbBVymTlt6CJj4WYC8MrOwsVTJ4pRufFGpXLJ
w7wm5ueFY/EAectLXqp3qNN/NsqviS8slXaeEt9oB/WSQJpTJagM09ypBxXtGKyU
vCuBgqXdSuDzD8DfOaTlGSsAKHwhAyXBdffvTIV0GVwlEhlqqRhGheAIZ767h49K
pDFByffeORIZOdKKyfkn
=BtPQ
-----END PGP SIGNATURE-----

--oLu9tqJUAW78NmtAT4sNV7skSPHvI78te--
