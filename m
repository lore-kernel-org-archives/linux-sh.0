From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Wed, 02 May 2012 12:02:25 +0000
Subject: Re: [PATCH v3 0/10] sh_flctl hardware ECC mode cleanup
Message-Id: <1335960145.10293.48.camel@sauron.fi.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-BH+tyhCdroakji+EdXYf"
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <1335955122.10293.39.camel@sauron.fi.intel.com>
 <CABYn4szhjH0N_DsGc=O0TtJZNUja1KDzZ7HWTnR5nQvnxZEVPQ@mail.gmail.com>
In-Reply-To: <CABYn4szhjH0N_DsGc=O0TtJZNUja1KDzZ7HWTnR5nQvnxZEVPQ@mail.gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org


--=-BH+tyhCdroakji+EdXYf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-02 at 13:51 +0200, Bastian Hecht wrote:
> Hi Artem,
>=20
> 2012/5/2 Artem Bityutskiy <dedekind1@gmail.com>:
> > On Wed, 2012-05-02 at 11:41 +0200, Bastian Hecht wrote:
> >> changelog v3:
> >>
> >> Just a rebase on current l2-mtd.git.
> >
> > Aiaiai says that your patch-set introduced several warnings, could you
> > please take a look:
> >
> > -----------------------------------------------------------------------=
---------
> >
> > Bisectability test results for configuration "l2_mackerel_defconfig,arm=
,arm-unknown-linux-gnueabi-"
> >
> > Bisecability test passed
> >
> > -----------------------------------------------------------------------=
---------
> >
> > Successfully built configuration "l2_mackerel_defconfig,arm,arm-unknown=
-linux-gnueabi-", results:
> >
> > --- before_patching.log
> > +++ after_patching.log
> > @@ @@
> > -drivers/mtd/nand/sh_flctl.c:264:30: warning: incorrect type in argumen=
t 1 (different address spaces) [sparse]
> > -drivers/mtd/nand/sh_flctl.c:264:30:    expected void const volatile [n=
oderef] <asn:2>*<noident> [sparse]
> > -drivers/mtd/nand/sh_flctl.c:264:30:    got void *fifo_addr [sparse]
> > +drivers/mtd/nand/sh_flctl.c:301:38: warning: incorrect type in argumen=
t 1 (different address spaces) [sparse]
> > +drivers/mtd/nand/sh_flctl.c:301:38:    expected void const volatile [n=
oderef] <asn:2>*<noident> [sparse]
> > +drivers/mtd/nand/sh_flctl.c:301:38:    got void *fifo_addr [sparse]
> > +drivers/mtd/nand/sh_flctl.c:326:28: warning: cast removes address spac=
e of expression [sparse]
> > +drivers/mtd/nand/sh_flctl.c:331:17: warning: incorrect type in argumen=
t 1 (different address spaces) [sparse]
> > +drivers/mtd/nand/sh_flctl.c:331:17:    expected void const volatile [n=
oderef] <asn:2>*<noident> [sparse]
> > +drivers/mtd/nand/sh_flctl.c:331:17:    got void *fifo_addr [sparse]
> > +drivers/mtd/nand/sh_flctl.c:967 flctl_probe() warn: 'irq' was not rele=
ased on error [smatch]
> >
> > -----------------------------------------------------------------------=
---------
>=20
> Nice! Every day I learn about a new tool for kernel developing. I
> cloned your aiaiai tree but am unsure how to run it as
> CONFIG_MTD_NAND_SH_FLCTL is not set in the mackerel_defconfig. Can you
> supply me with a command line how you tested it?

For the trees I maintain I have this repository:

git://git.infradead.org/users/dedekind/maintaining.git

where I store various helper scripts. To test your patch-set I used
"l2-mtd-sh_flctl.sh" script, I run it like this:

../aiaiai/concat-mbox-files ~/tmp/bastian* | ./l2-mtd-general.sh

where ../aiaiai is a clone of aiaiai repository:

git://git.infradead.org/users/dedekind/aiaiai.git

and the concat-mbox-files is a helper script which concatenates several
mbox files. The ~/tmp/bastian* are your patches saved as mbox.

Those helper scripts require you to clone the l2-mtd.git tree and
checkout the "defconfigs" branch which contains the
'l2_makerel_defconfig' configuration.

Aiaiai also needs several packages to be installed - see README file in
the aiaiai repo. It also needs smatch and sparse - also documented in
README. Sorry that this stuff is not too user-friendly - I do not have
time to clean it up.

Feel free to ask for help.

--=20
Best Regards,
Artem Bityutskiy

--=-BH+tyhCdroakji+EdXYf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPoSJRAAoJECmIfjd9wqK0D6UQALeSf1awSNhZhsLs4r0mRV7O
z11uNYfkFAnu1Z+0Xn6Qt1BRYw3EVRJsscxktfMIQiyWjfmrs6w8f+CSc9UrNs68
FqqQkG6JRhe35D7i98mQvVPZDamxZoi3//Ls1EJe+WkGeCzk4Q3bqpVKP6+VFWws
mgsO+MiUfre7fXr2VuI9Lb6EPca7VIkO/saosBHQZ8RpvqTGMyC5VoZVPNphzwng
YdbL6ksgylJ5LeAT5u6+J4x9VefMa11ZmuZfIwdf5duJLrdGl1NKw4IoekJSTHYz
PQt4mugqaNOa137rzMHoW1jUVSrj38gouMVLArfvmZ5F1Kr0/NvrXsWs14+pfdFG
HxTQvMR1c7Dj5dK0HCPPk9gw9iX+LHySFnHqF1azD6Ce/RboYNaXR9npmLc/Pg31
MvFXB3vr40wRT3nQIIhwAaziRz8gA+e10L2HGZ9V4a1yp2UxQViRtgurIZGKkA0q
4HOdWsAYdPt7YEW3rA+0kx/rOZoytTdlKYv3CUANtQIuSbQogsWHKMlOf4Aim+yw
Y5fgrGYWFiG1IznjXcy0bQt6cn4t/84+UvhuNdrSJmRzY+x7mzYEnbMHsvSHeSVU
Agv5NfmWOwhS/NC1xwD28p/H5S0GeGOYWQEzDmCEaaehcXC0cuytZ469o1zYEKS1
EAVOa51F3+Ha20KXPpcJ
=i+fC
-----END PGP SIGNATURE-----

--=-BH+tyhCdroakji+EdXYf--

