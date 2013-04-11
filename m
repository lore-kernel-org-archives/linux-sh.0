From: Felipe Balbi <balbi@ti.com>
Date: Thu, 11 Apr 2013 12:06:49 +0000
Subject: Re: [PATCH v3 0/9] Reorganize R8A7779/Marzen USB code
Message-Id: <20130411120649.GM14394@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="57SHPaztv6dlLu/a"
List-Id: <linux-sh.vger.kernel.org>
References: <201304100226.08967.sergei.shtylyov@cogentembedded.com>
 <20130410044923.GD10044@verge.net.au>
 <20130410085033.GL7983@arwen.pp.htv.fi>
 <20130410090543.GB25890@verge.net.au>
 <20130411005155.GA18530@verge.net.au>
 <5166A659.6060405@cogentembedded.com>
In-Reply-To: <5166A659.6060405@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org

--57SHPaztv6dlLu/a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 11, 2013 at 04:02:33PM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 11-04-2013 4:51, Simon Horman wrote:
>=20
> >>>>>    Here's the set of 9 patches against the Simon Horman's 'renesas.=
git' repo,
> >>>>>'renesas-next-20130410' tag.  It was created to fix the shortcomings=
 in the
> >>>>>R8A7779/Marzen USB platform code and R8A7779 USB common PHY driver, =
and so
> >>>>>spans both arch/arm/mach-shmobile/ and drivers/usb/ subtrees (some p=
atches have
> >>>>>to touch both subtrees). The patches were conceived with the complete
> >>>>>bisectability goal in mind.
>=20
> >>>>>[1/9] ARM: shmobile: Marzen: move USB EHCI, OHCI, and PHY devices to=
 R8A7779 code
> >>>>>[2/9] ehci-platform: add pre_setup() method to platform data
> >>>>>[3/9] ARM: shmobile: R8A7779: setup EHCI internal buffer
> >>>>>[4/9] rcar-phy: remove EHCI internal buffer setup
> >>>>>[5/9] ARM: shmobile: R8A7779: remove USB PHY 2nd memory resource
> >>>>>[6/9] rcar-phy: correct base address
> >>>>>[7/9] rcar-phy: add platform data
> >>>>>[8/9] ARM: shmobile: Marzen: pass platform data to USB PHY device
> >>>>>[9/9] rcar-phy: handle platform data
>=20
> >>>>>    I'm not sure thru which tree this patchset should be merged, how=
ever it turns
> >>>>>out that it's too late now to push it thru Felipe Balbi's USB tree f=
or 3.10
> >>>>>(which would have been most convenient probably), and it's probably =
too late to
> >>>>>merge thru Simon's tree for 3.10 too. So it now have to be postponed=
 to 3.11,
> >>>>>unfortunately...
>=20
> >>>>Felipe, how would you prefer to handle this?
> >>>>I'm happy for you to take it or to take it myself.
>=20
> >>>please take it yourself, just keep in mind there will be conflicts, I
> >>>will go over the patches now and give my Acked-by so you can queue them
> >>>up.
>=20
> >>Thanks
>=20
> >Sergei, it looks like patches 1-7 are clear.
>=20
>    #7 & #9 have been refused by Felipe (hence #8 isn't good too).
>=20
> >Do you want me to start queueing them up.
>=20
>    I was going to repost the whole series soon, adding ACK from Alan
> to the patch #2 and resolving issues with patches #7..#9. It's worth
> waiting for that to happen I think.
>=20
> >Or would you rather wait for the issue with patch 6 to be resolved?
>=20
>    There's no special issue with patch #6 other than the PHY driver
> files being renamed in Felipe's tree -- but that concerns all patches
> touching drivers/usb/phy/rcar-phy.c (some of which precede #6).
>    I don't know how the rename conflict will be handled (this is
> really bad coincidence), perhaps I still should have done this
> patchset against Felipe's 'next' branch and pushed it thru his tree.
> If the patches will be queued for 3.11 anyway, maybe it's worth doing
> that -- I'm still of the opinion that his tree would be the one most
> fitting for this patchset.

git can handle renames well, don't worry. Conflict will be easy to
resolve.

--=20
balbi

--57SHPaztv6dlLu/a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZqdZAAoJEIaOsuA1yqREyesP/0LkH8Xzl2WLIlg7oUh0pVXT
9NkKUs+jcSa0JOMPitS2aKQvhltrdtELaF8jtl9p6Cj2HrLXcavoG0scI5riL7V1
ZWdOdL2In1EXVEnKatElkbnwAC4+1rCyl0zaoIeARirL5c0SIrOeaVYPJcwDJnAh
SOrdsp7/YokcpmxXVJSoEY081HZOmoEcilP79AMNiArhAlrliB6AtzNP6fE+IETP
amoZgCYIYdlzMRgtLomwA5XazFULaBxPKftk3ed/RZLm19t2NugXP/PUFoRrKXt/
WJ9dtIcTW4gWFf+4KFnq2DtIseJqXkSP3mha/uKwfI6L4qoWsevddEoZjOlIiJKs
6ao5OK2pj3bQuPejD7TGXaHwjy/D+NKGJU3yzfJ9Vvlhe9m4Us1It5CeBFEiFY9e
K2vaEFiZOSEhQt0sa/G9mL/TeRO2DxwFEmorJhe0wevYzpvGYvz9bA9V73m6g5sF
jtBZoVibev/7YeVQj9/9ajpQ3u/YyFEBwHSPAoNLroGOX9457nZTREZGMiQhUy17
/DAfb7v3E59V8lV4Z8VWuKiPMeQg2Ewy4e42E5qBWLgpvIA5sBO9GW6DH9MLKT36
cG7uPQA8dUUxy5+Wd/N+EhkLxf55qQRwyOXUjwu3Xw4n6zEOgnQbdSl1sllNhMWW
heza/tV8elWJSOWRUZNe
=dCYq
-----END PGP SIGNATURE-----

--57SHPaztv6dlLu/a--
