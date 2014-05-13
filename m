From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 13 May 2014 21:59:29 +0000
Subject: Re: [PATCH v5 01/11] ARM: shmobile: r7s72100: document MSTP clock support
Message-Id: <20140513215929.GA3967@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
List-Id: <linux-sh.vger.kernel.org>
References: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
 <1398765822-2314-2-git-send-email-wsa@the-dreams.de>
 <20140513000513.5943.68810@quantum>
 <20140513015708.GA29336@verge.net.au>
In-Reply-To: <20140513015708.GA29336@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simon,

> Its a getting a little to close to rc6 for me to take this series for v3.=
16,
> especially considering some bits seem to need tweaking (I am thinking of =
sci).
>=20
> Could you either:
>=20
> * Re-post it without the sci changes and
>   I'll look at queuing it up for v3.17 or;

If it is possible and does not cause too much burden for you, I'd prefer
to include it soonish and handle the fixups incrementally. Since it
touches a few files which change a lot, rebasing and retesting is extra
work (done twice for this series IIRC) and thus I'd prefer to do the
clenaups as seperate patches.

So, if no one objects, I'll resend tomorrow with Geerts fixup folded
into my series and retested against latest renesas/devel.


--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTcpXBAAoJEBQN5MwUoCm2ISIP/2RRBowH+TPU6i9bMdMFL8JN
vUN44cAPoFleZ6/DycREntRHe/CEk9KcDC4HVwtRsVPJSBBLCuxrbN47ovU+RWYc
CsDDk5QD6lG9ReQ71s3SlAIK4MpF1ZcusjGqKxrXdaOIlWG66cd0W8E311msNlmx
vASVv4DMrFUlu/0GbBvrmTFLLdRdhfMKFOjLH/c5B2wP4c7uXAtipfECUQAZh/58
xBUs2RyydXLvgKQpr5aZbzreQfz8n4tyT7whp7vnW+sDFjIq6OUpcSuqJbKGZ40k
I9puuuXqZCSPWRsd11N/NeOsY2iJJrbJ1GuRHQxTGhLlicdREfoVl764eRv6IV9R
ebljCw6pp9I9T9QMcGp4NcJe0zEYtFNutXBwl+Jt0pn/Dz2NhLXIX1eyoMk7BeNe
AGmX7CBCmUWMJwFc9KG/IjTLTJFYy0uQ0WTVJYp89JJKavn04U05rCXaKntzK3bl
tJONB/aq3eDTfzoamOnOsISNtqNX0Z58vwYp66Lv5B5zp5CkLxNeyS3BMYNoyoz4
nZOEvx0Cx2VR1xd/RWJ+AAN+h9ZQESx6W34KEafaZp8xWMfQ1yjHl4IRAdJmKRBS
jacrRXJoGBOwr64CS7PBwe+AbV/TdpfTAFonx9aNb5EPern9xmE2LsWbhmaWVqiE
0LjxYFedy+AHjTSLXyAl
=c6qS
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
