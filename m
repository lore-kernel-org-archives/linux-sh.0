From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 12 Mar 2014 12:26:37 +0000
Subject: Re: [PATCH 00/22] SH MTU2 DT support
Message-Id: <7154417.GQCi9BMEKT@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart32435673.rWEfVlxA0B"
List-Id: <linux-sh.vger.kernel.org>
References: <1393955249-18736-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393955249-18736-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--nextPart32435673.rWEfVlxA0B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Wednesday 12 March 2014 09:29:44 Wolfram Sang wrote:
> On Tue, Mar 04, 2014 at 06:47:07PM +0100, Laurent Pinchart wrote:
> > Hello,
> >=20
> > This patch set implements DT support for the MTU2 driver.
> >=20
> > The first 17 patches clean up the driver to get rid of its platform=
 data.
> > Patches 18/22 and 19/22 then remove platform data from arch/ code. =
Patches
> > 20/22 and 21/22 drop support for platform data completely from the =
driver,
> > and patch 22/22 finally add DT support.
> >=20
> > The patches are compile-tested only as I lack test hardware. Wolfra=
m,
> > would you be able to test this series with your CCF support patch s=
et for
> > RZ/A1H ?
>
> Applying to current renesas/devel fails. What is this based on? Or
> better: is there a branch available somewhere?

I've just rebased my timers devel branch on top of Simon's latest devel=
 branch=20
and pushed the result to

=09git://linuxtv.org/pinchartl/fbdev.git timers/devel

Please ignore the WIP and other hacks before "clocksource: sh_mtu2: Use=
=20
request_irq() instead of setup_irq()", and the very last "ARM: shmobile=
:=20
Remove unused sh_timer_config members" patch.

=2D-=20
Regards,

Laurent Pinchart

--nextPart32435673.rWEfVlxA0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTIFKDAAoJEIkPb2GL7hl1IvQH/jgAfy+sQ8bpr+jKIZx2ggVr
YTiKlPl5/CLvKPPdZYzn9tJvluTydsotW/Taewp1ewFUf4HFWkHsC9QLI94WD2vL
QVIa+h/7YYIhaJaGUBQSVqw6pOvqxw/Erkybp2agZs0gfmcQSexxVvXjkR66kQbg
eMZivy3Gp1q5cVPdKBtzp8bYij1uvruTMY6w+2RazWwIBiE5DDrN9gg6PPYZfF30
jkRh2/MgZDLKAD3hvI7ndaDWHM5WjKT2sTQHx7e1MURq/ChnQvjTQSZ1DXsy+Z1k
/W1f2JWPKXmcerYbK7zJwJbBKq6y2lA9T6uhsnHbSKHVNJ0FzARraLTJwGZspTk=
=7VdJ
-----END PGP SIGNATURE-----

--nextPart32435673.rWEfVlxA0B--

