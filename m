From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 03 Mar 2014 09:19:04 +0000
Subject: Re: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
Message-Id: <20140303091903.GA6531@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1393621768-12568-4-git-send-email-wsa@the-dreams.de>
 <1569751.q5lJmQcb3K@avalon>
In-Reply-To: <1569751.q5lJmQcb3K@avalon>
To: linux-arm-kernel@lists.infradead.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >  drivers/clk/shmobile/Makefile |   1 +
> >  drivers/clk/shmobile/clk-rz.c | 112 ++++++++++++++++++++++++++++++++++=
+++++
>=20
> There's one large missing piece here: the DT bindings documentation.

Yes, noticed that, too. Added already.

> > +	u32 val;
> > +	unsigned mult, frqcr_tab[4] =3D { 3, 2, 0, 1 };
>=20
> I would declare the table as static const outside of this function.

Yup.

> > +	if (strcmp(name, "pll") =3D=3D 0) {
> > +		/* FIXME: cpg_mode should be read from GPIO. But no GPIO support yet=
=20
> */
> > +		unsigned cpg_mode =3D 0; /* hardcoded to EXTAL for now */
>=20
> It won't make a difference yet, but shouldn't this be moved to=20
> rz_cpg_clocks_init() ?

This is going to be a gpio_get_value() later and I'd prefer it in the
place where the value is needed.

>=20
> > +		const char *parent_name =3D of_clk_get_parent_name(np, 0);
>=20
> You should select the parent depending on the mode (again it won't make a=
ny=20
> difference yet, but the code will be ready, and DT bindings should docume=
nt=20
> two parents).

Two parents? Yet, CPG only needs one as input. Either XTAL or USB_X1
which is board dependent. What I should do IMO is to put the parent
property for CPG from the dtsi to the board dts. Because this is
describing hardware. And from that parent, I can simply get its name
like above.

> > +	int num_clks;
> > +
> > +	num_clks =3D of_property_count_strings(np, "clock-output-names");
> > +	if (WARN(num_clks < 0, "can't count CPG clocks\n"))
>=20
> Do such failures really deserve a WARN ? Isn't a pr_err() enough ?

Since the system won't probably boot, I'd think so. Also, it makes the
code more concise, no?

> What if num_clks =3D=3D 0 ?

Good question.

>=20
> > +		goto out;
> > +
> > +	cpg =3D kzalloc(sizeof(*cpg), GFP_KERNEL);
> > +	if (WARN(!cpg, "out of memory!\n"))
> > +		goto out;
> > +
> > +	clks =3D kzalloc(num_clks * sizeof(*clks), GFP_KERNEL);
> > +	if (WARN(!clks, "out of memory!\n"))
> > +		goto free_cpg;
>=20
> Does kzalloc alloc warn internally when it fails to allocate memory ?

Ehrm, why don't you simply look this up instead of asking me? :)

> you could remove the error message. You could also perform the two alloca=
tions=20
> and check the result once only.

What is the gain? Code savings?

> > +free_clks:
> > +	kfree(clks);
> > +free_cpg:
> > +	kfree(cpg);
>=20
> I would remove that as done in the other CPG drivers, given that a small=
=20
> memory leak when the system will anyway fail to boot isn't really an issu=
e.

Again, now that I already coded it, what is the gain to remove it? The
drawback is that other people might get encouraged to find reasons to
allow them sloppy practices.

Thanks,

   Wolfram


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTFEkHAAoJEBQN5MwUoCm2//wQAJe2cgVSV2YexrURFs3x7zaA
k+ZZjwZpMl/REA+zZO3TOpnipYQmUxV7PI4TRZYzAEgkquq8ElZh6IQweL9TV8lR
AjmjQRymUEuMK15VvqJiGFSAnCDzl+GfYBDDkt5FdbHnwWU+QyBabwY3DFqNzLeR
6iWen8gnHjxChL+WHbrBL0GfrplIPilpzsgoE4YVvhPXM5+nBWZDiqeqDvJn/4U1
6iHyTOToQWKy7gxe4u0Q6Tft0Fyerr+1Kq4JLHkXZCCSDj57YfMA1Phm6uV8T5HG
eAGbBIzCEuPIgP/cvashky6xywJFG7DcjAOKKI5E+P0Qk9akBlABH4isA/8d1HMR
892sKBNEOrqHA4qpAz228I6i4BUV8MYQ/gXCTNdTj6pp+qbjKegtYMjZD+qsfMfZ
e5pu3FNUb2qYykg3U9dG0YM+VRdptQQwbuUvxFB1UBeP5xa88jg7Vr3SPWYOYMCW
QWqztQ83CKWfCI1yZNKtZWHcKo9ja5MzNoggicoB9AwkekWWUgu32rnUXwrjfP1C
LQ2ZA4S6fmSC+lBy+VgRxpvw86sey8She2rFtO7UmMKcSM+KkMp76W66mRD/+5ZW
dQDRhusIZ/a5SedVcGM7jGmKKJQAdKYt6l/5N+CRVE03mizfxLS4B7YpMeQ4onva
iRR6GcEGqBRdE7XhTrxt
=WUAJ
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
