From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 07 Jun 2015 11:16:32 +0000
Subject: Re: [PATCH] TESTCASE: of: OOPS when disabling node via OF_DYNAMIC
Message-Id: <20150607111632.CC7A4C410F0@trevor.secretlab.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <1427814771-30335-1-git-send-email-wsa@the-dreams.de>
	<AEA6F5CA-D520-4F34-BE6B-EF2839501089@konsulko.com>
	<20150414132709.GA1375@katana>
	<83B5C458-8D49-4EF6-9F4A-6C0E2579AB9F@konsulko.com>
In-Reply-To: <83B5C458-8D49-4EF6-9F4A-6C0E2579AB9F-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 22 Apr 2015 15:30:28 +0300
, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
 wrote:
> Hi Wolfram,
>=20
> > On Apr 14, 2015, at 16:27 , Wolfram Sang <wsa@the-dreams.de> wrote:
> >=20
> > Hi Pantelis,
> >=20
> > thanks for your prompt reply. Unfortunately, I had to wait until I could
> > access the test system again.
> >=20
>=20
> [snip]
>=20
> Sorry for the non-prompt reply; but just for kicks, can you try the attac=
hed patch?
>=20
> I have a hunch this might be the problem.
>=20
> Regards
>=20
> =E2=80=94 Pantelis
>=20
>=20

I played around with this some today. If I'm reading it correctly, the
following patch reproduces the same problem:

(continued below patch)
---
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 18016341d5a9..0a27b38c3041 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -753,6 +753,11 @@ static void __init of_unittest_match_node(void)
 	}
 }
=20
+static struct resource test_bus_res =3D {
+	.start =3D 0xfffffff8,
+	.end =3D 0xfffffff9,
+	.flags =3D IORESOURCE_MEM,
+};
 static const struct platform_device_info test_bus_info =3D {
 	.name =3D "unittest-bus",
 };
@@ -795,6 +800,7 @@ static void __init of_unittest_platform_populate(void)
 	if (rc)
 		return;
 	test_bus->dev.of_node =3D np;
+	platform_device_add_resources(test_bus, &test_bus_res, 1);
=20
 	of_platform_populate(np, match, NULL, &test_bus->dev);
 	for_each_child_of_node(np, child) {

---

I think the fixup patch boils down to the following. It's hard to tell
because it combines refactoring with the bug fix. Do I have it correct?
If so, I'd rather commit the simple fix which can be committed now for
v4.1, and the refactoring can be pushed for v4.2

---

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index ebf034b97278..b3042e6ee3ef 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -377,7 +377,7 @@ int platform_device_add(struct platform_device *pdev)
 		struct resource *r =3D &pdev->resource[i];
 		unsigned long type =3D resource_type(r);
=20
-		if (type =3D IORESOURCE_MEM || type =3D IORESOURCE_IO)
+		if (r->parent)
 			release_resource(r);
 	}
=20
@@ -410,7 +410,7 @@ void platform_device_del(struct platform_device *pdev)
 			struct resource *r =3D &pdev->resource[i];
 			unsigned long type =3D resource_type(r);
=20
-			if (type =3D IORESOURCE_MEM || type =3D IORESOURCE_IO)
+			if (r->parent)
 				release_resource(r);
 		}
 	}

