From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 04 Mar 2014 11:13:42 +0000
Subject: Re: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
Message-Id: <3106573.JU29eCDXeo@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart6425697.9MIYCE430q"
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <2207635.bd10VfTU6U@avalon> <20140304110706.GA12727@katana>
In-Reply-To: <20140304110706.GA12727@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart6425697.9MIYCE430q
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Tuesday 04 March 2014 12:07:06 Wolfram Sang wrote:
> > > > While the parent is indeed selected at boot time only, and only=
 one
> > > > parent is thus needed, parent selection could be performed by a=
 DIP
> > > > switch connected to MD_CLK on the board for instance. In that c=
ase
> > > > both parents should be available in DT, as selection will be do=
ne by
> > > > the kernel at boot time, not at DT compile time.
> > >=20
> > > OK, I understand the case. I still wonder about specifying two pa=
rents,
> > > though. If a board uses USB_X1, it then has to spefify a dummy EX=
TAL
> > > clock (or an empty one), just because USB_X1 is enumerated as sec=
ond
> > > entry?
> >=20
> > That's a good question. Mike, would it be possible to support "hole=
s" in
> > the DT clocks lists, like the GPIO DT bindings do ?
>=20
> I am currently playing with the status property for clocks, so we can=

> "disable" clocks. Opinions?

Could you please provide an example of how you would like to use that ?=


> From: Wolfram Sang <wsa@sang-engineering.com>
> Subject: [PATCH] clk: allow clocks to use the 'status' property
>=20
> Similar to platform devices, this allows us to set up the clock
> hierarchy in dtsi files and enable the used clocks in the board file
> later.
>=20
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
>  drivers/clk/clk.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 5517944..0045f55 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2542,6 +2542,9 @@ void __init of_clk_init(const struct of_device_=
id
> *matches) matches =3D &__clk_of_table;
>=20
>  =09for_each_matching_node_and_match(np, matches, &match) {
> +=09=09if (!of_device_is_available(np))
> +=09=09=09continue;
> +
>  =09=09of_clk_init_cb_t clk_init_cb =3D match->data;
>  =09=09clk_init_cb(np);
>  =09}

=2D-=20
Regards,

Laurent Pinchart

--nextPart6425697.9MIYCE430q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTFbVmAAoJEIkPb2GL7hl1ZHAH/AmIK/UnnksIb+O5RcmUpdbi
1A/5BmJmXAB4sftnbAgQPfQ7TjcbgY4EHcDR007PyIFrXeHA3WRkU4AAIcMkynV/
cKK9/1Gl3OgLeyGCjOUeWjpFSu7StTJj9B/8TVXq3+PpvycHtq/KuQTIeKMW1r2w
ouF7YrqWjaIsNu3hrUoA25h7KZCYkEFFnIy/peieomk6lZmLklFUvbQV6x/crR5d
8jdoyFlBXuazCPm3IQ4qD5sCo2945iTSWH64QahC+GegXycBsZAEmsyYnrA5425H
7DJHy+Qep/d0FgDl8DajYKRCwDobTZQaT7tQQyLVoTsXU/sERrSYjyY/hxo6vwk=
=0y1C
-----END PGP SIGNATURE-----

--nextPart6425697.9MIYCE430q--

