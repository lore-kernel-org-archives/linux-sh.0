From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 09 Jun 2015 16:50:26 +0000
Subject: Re: [PATCH] TESTCASE: of: OOPS when disabling node via OF_DYNAMIC
Message-Id: <2309597.bA1dyPGh92@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1427814771-30335-1-git-send-email-wsa@the-dreams.de> <83B5C458-8D49-4EF6-9F4A-6C0E2579AB9F@konsulko.com> <20150607111632.CC7A4C410F0@trevor.secretlab.ca>
In-Reply-To: <20150607111632.CC7A4C410F0@trevor.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org

Hi Grant,

On Sunday 07 June 2015 12:16:32 Grant Likely wrote:
> On Wed, 22 Apr 2015 15:30:28 +0300, Pantelis Antoniou wrote:
> > > On Apr 14, 2015, at 16:27 , Wolfram Sang <wsa@the-dreams.de> wrote:
> > >=20
> > > Hi Pantelis,
> > >=20
> > > thanks for your prompt reply. Unfortunately, I had to wait until I co=
uld
> > > access the test system again.
> >=20
> > [snip]
> >=20
> > Sorry for the non-prompt reply; but just for kicks, can you try the
> > attached patch?
> >=20
> > I have a hunch this might be the problem.
> >=20
> > Regards
> >=20
> > =E2=80=94 Pantelis
>=20
> I played around with this some today. If I'm reading it correctly, the
> following patch reproduces the same problem:
>=20
> (continued below patch)
> ---
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 18016341d5a9..0a27b38c3041 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -753,6 +753,11 @@ static void __init of_unittest_match_node(void)
>  	}
>  }
>=20
> +static struct resource test_bus_res =3D {
> +	.start =3D 0xfffffff8,
> +	.end =3D 0xfffffff9,
> +	.flags =3D IORESOURCE_MEM,
> +};
>  static const struct platform_device_info test_bus_info =3D {
>  	.name =3D "unittest-bus",
>  };
> @@ -795,6 +800,7 @@ static void __init of_unittest_platform_populate(void)
>  	if (rc)
>  		return;
>  	test_bus->dev.of_node =3D np;
> +	platform_device_add_resources(test_bus, &test_bus_res, 1);
>=20
>  	of_platform_populate(np, match, NULL, &test_bus->dev);
>  	for_each_child_of_node(np, child) {
>=20
> ---
>=20
> I think the fixup patch boils down to the following. It's hard to tell
> because it combines refactoring with the bug fix. Do I have it correct?
> If so, I'd rather commit the simple fix which can be committed now for
> v4.1, and the refactoring can be pushed for v4.2

The patch below looks equivalent to Pantelis' patch if we remove the=20
refactoring, but I don't immediately see how r->parent can be NULL in=20
platform_device_del() if type is equal to IORESOURCE_MEM or IORESOURCE_IO, =
as=20
platform_device_add() will have called insert_resource() in those cases, wh=
ich=20
should set the resource parent pointer. I must be missing something as the =

patch fixes Wolfram's issue, so an explanation in the commit message would =
be=20
welcome.

> ---
>=20
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index ebf034b97278..b3042e6ee3ef 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -377,7 +377,7 @@ int platform_device_add(struct platform_device *pdev)
>  		struct resource *r =3D &pdev->resource[i];
>  		unsigned long type =3D resource_type(r);
>=20
> -		if (type =3D IORESOURCE_MEM || type =3D IORESOURCE_IO)
> +		if (r->parent)
>  			release_resource(r);
>  	}
>=20
> @@ -410,7 +410,7 @@ void platform_device_del(struct platform_device *pdev)
>  			struct resource *r =3D &pdev->resource[i];
>  			unsigned long type =3D resource_type(r);
>=20
> -			if (type =3D IORESOURCE_MEM || type =3D IORESOURCE_IO)
> +			if (r->parent)
>  				release_resource(r);
>  		}
>  	}

--=20
Regards,

Laurent Pinchart

