From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 04 Jan 2016 12:17:47 +0000
Subject: [PATCH v2] of/unittest: Show broken behaviour in the platform bus (fwd)
Message-Id: <20160104121746.GE1524@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="phCU5ROyZO6kBE05"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


FYI, I forgot to cc this list...

----- Forwarded message from Wolfram Sang <wsa@the-dreams.de> -----

Date: Mon,  4 Jan 2016 13:13:21 +0100
=46rom: Wolfram Sang <wsa@the-dreams.de>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Pantelis Antoniou <pantelis.antoniou@=
konsulko.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@li=
nuxfoundation.org>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Rob
	Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant=
 Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org
Subject: [PATCH v2] of/unittest: Show broken behaviour in the platform bus
Message-Id: <1451909614-5519-1-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.4

=46rom: Grant Likely <grant.likely@linaro.org>

Add a single resource to the test bus device to exercise the platform
bus code a little more. This isn't strictly a devicetree test, but it is
a corner case that the devicetree runs into. Until we've got platform
device unittests, it can live here. It doesn't need to be an explicit
text because the kernel will oops when it is wrong.

Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Grant Likely <grant.likely@linaro.org>
[wsa: added the comment provided by Grant, rebased, and tested]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/of/unittest.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

I found this patch in one of my branches and think it is still worth applyi=
ng.
In v1, Rob wanted a comment added which Grant provided but never folded into
the patch. I have done so now :) Note that the fix to this problem was alre=
ady
picked up by Rob.

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e16ea5717b7f76..bbff09dee1cf45 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -757,6 +757,11 @@ static void __init of_unittest_match_node(void)
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
@@ -800,6 +805,15 @@ static void __init of_unittest_platform_populate(void)
 		return;
 	test_bus->dev.of_node =3D np;
=20
+	/*
+	 * Add a dummy resource to the test bus node after it is
+	 * registered to catch problems with un-inserted resources. The
+	 * DT code doesn't insert the resources, and it has caused the
+	 * kernel to oops in the past. This makes sure the same bug
+	 * doesn't crop up again.
+	 */
+	platform_device_add_resources(test_bus, &test_bus_res, 1);
+
 	of_platform_populate(np, match, NULL, &test_bus->dev);
 	for_each_child_of_node(np, child) {
 		for_each_child_of_node(child, grandchild)
--=20
2.1.4


----- End forwarded message -----

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWimLqAAoJEBQN5MwUoCm2VrsQAIRG1xyM7tKoOka7mVdVvCgH
cpGitvbKbwhWYWYEjeM9+2RoyPP0UBejo265K+9RB2QD4X5PfW2bVg+js7YCzGRi
R+xQ4Fahq9fwnWs/paTDEfDn98FvzBV3eahe4Mo+S3XsM5VP/37feM95lY9ZUFee
Gja11dtf61lEx9YYm4hne41KdYC40yEgqREh4CN7Z46DudqsHsGlX358/lsjEh8H
hei3sucUokYXq5WEDy+G1lMHuuRigSh3ex+2QB/aXjwvldw2QQgv59ozgY8L1Dcl
+9gZtYKHYDuYeAILMFkvgRMeyaHOp21Y/8YvTxr0wd/rj5T2+e8HfEAzE6jg2vru
P8BztB9qGS/Hqy2z7aWtM0s3R9Ue+yGIFharB09tKAppK6SVdCqdn7JK7+glvkNx
dOvxy/TxHeB6RAnPHi90gkWbeH58Riyzqae7Vb4L9PIKfI/+Jx4iLD1Nyd85BtFs
/5W5CnCewwlg+BjIvq+wPLW61VPWPhjmfWYKUp75S+K3r28L1y/PmhMXV9Da0AdD
uNwjIw5f58ll9oA9nxo1rLeV2bX2XL/j1gdxScuduUSjGhba2N+teukycUVNqNdc
pJd0fdeKzxGwtg9A92WDO6xDIVGG9e0fM4aG7zi9X9g5K4y5dQKtR/qFp5beLi6n
NSGC07jQzPzFJJJ5PwxU
=QiAD
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
