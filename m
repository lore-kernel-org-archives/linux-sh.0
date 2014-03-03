From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 03 Mar 2014 10:59:24 +0000
Subject: Re: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
Message-Id: <1722697.3h0GnbWuD3@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1578649.QpbCq8WB8Z"
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1569751.q5lJmQcb3K@avalon> <20140303091903.GA6531@katana>
In-Reply-To: <20140303091903.GA6531@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart1578649.QpbCq8WB8Z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Monday 03 March 2014 10:19:04 Wolfram Sang wrote:
> > >  drivers/clk/shmobile/Makefile |   1 +
> > >  drivers/clk/shmobile/clk-rz.c | 112 ++++++++++++++++++++++++++++=
+++++++
> >=20
> > There's one large missing piece here: the DT bindings documentation=
.
>=20
> Yes, noticed that, too. Added already.
>=20
> > > +=09u32 val;
> > > +=09unsigned mult, frqcr_tab[4] =3D { 3, 2, 0, 1 };
> >=20
> > I would declare the table as static const outside of this function.=

>=20
> Yup.
>=20
> > > +=09if (strcmp(name, "pll") =3D=3D 0) {
> > > +=09=09/* FIXME: cpg_mode should be read from GPIO. But no GPIO s=
upport
> > > yet */
> > > +=09=09unsigned cpg_mode =3D 0; /* hardcoded to EXTAL for now */
> >=20
> > It won't make a difference yet, but shouldn't this be moved to
> > rz_cpg_clocks_init() ?
>=20
> This is going to be a gpio_get_value() later and I'd prefer it in the=

> place where the value is needed.
>=20
> > > +=09=09const char *parent_name =3D of_clk_get_parent_name(np, 0);=

> >=20
> > You should select the parent depending on the mode (again it won't =
make
> > any difference yet, but the code will be ready, and DT bindings sho=
uld
> > document two parents).
>=20
> Two parents? Yet, CPG only needs one as input. Either XTAL or USB_X1
> which is board dependent. What I should do IMO is to put the parent
> property for CPG from the dtsi to the board dts. Because this is
> describing hardware. And from that parent, I can simply get its name
> like above.

While the parent is indeed selected at boot time only, and only one par=
ent is=20
thus needed, parent selection could be performed by a DIP switch connec=
ted to=20
MD_CLK on the board for instance. In that case both parents should be=20=

available in DT, as selection will be done by the kernel at boot time, =
not at=20
DT compile time.

> > > +=09int num_clks;
> > > +
> > > +=09num_clks =3D of_property_count_strings(np, "clock-output-name=
s");
> > > +=09if (WARN(num_clks < 0, "can't count CPG clocks\n"))
> >=20
> > Do such failures really deserve a WARN ? Isn't a pr_err() enough ?
>=20
> Since the system won't probably boot, I'd think so. Also, it makes th=
e
> code more concise, no?
>=20
> > What if num_clks =3D=3D 0 ?
>=20
> Good question.
>=20
> > > +=09=09goto out;
> > > +
> > > +=09cpg =3D kzalloc(sizeof(*cpg), GFP_KERNEL);
> > > +=09if (WARN(!cpg, "out of memory!\n"))
> > > +=09=09goto out;
> > > +
> > > +=09clks =3D kzalloc(num_clks * sizeof(*clks), GFP_KERNEL);
> > > +=09if (WARN(!clks, "out of memory!\n"))
> > > +=09=09goto free_cpg;
> >=20
> > Does kzalloc alloc warn internally when it fails to allocate memory=
 ?
>=20
> Ehrm, why don't you simply look this up instead of asking me? :)

I have and wasn't sure :-)

> > you could remove the error message. You could also perform the two
> > allocations and check the result once only.
>=20
> What is the gain? Code savings?

Yes, code saving.

> > > +free_clks:
> > > +=09kfree(clks);
> > > +free_cpg:
> > > +=09kfree(cpg);
> >=20
> > I would remove that as done in the other CPG drivers, given that a =
small
> > memory leak when the system will anyway fail to boot isn't really a=
n
> > issue.
>=20
> Again, now that I already coded it, what is the gain to remove it? Th=
e
> drawback is that other people might get encouraged to find reasons to=

> allow them sloppy practices.

It will make the kernel binary smaller by removing code that is not nee=
ded in=20
practice.

=2D-=20
Regards,

Laurent Pinchart

--nextPart1578649.QpbCq8WB8Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTFGCMAAoJEIkPb2GL7hl1bkIIAJd/VZobUnvGBdAnhbw67hNo
7/pM5pfPMbWdN96G5zIC2elfre+DmMWB1WfW+fmhpDCHapCPoXkRYAqryMkx2XOx
DRpASJqxcXbwvArYBOA/fFDG/XJ4KbYLY6kSHEHx6PMaF7pIhX9FLUVA2vloBC4+
qruzsPMsF3NdY7UnIqQeloLOEb8W4ZvPHwxqbOA1N9Twfmn1GKXPn+ZA9T5em2mX
rwD3cU2SZE6LFVIZwAq0GbX2i2FrmMyL5l7G/HOBmzed0kOhyEHHWC2MBrNapGnV
Pf1RbpOQKO1j+/UQxq41+51y8FbC9tAQ6+KE6z+uH2j+VTf/F83jIcbZ2Oq639c=
=kIMU
-----END PGP SIGNATURE-----

--nextPart1578649.QpbCq8WB8Z--

