From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Wed, 02 May 2012 10:38:42 +0000
Subject: Re: [PATCH v3 0/10] sh_flctl hardware ECC mode cleanup
Message-Id: <1335955122.10293.39.camel@sauron.fi.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-y236Uy9szDvMFQpG6aWL"
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org


--=-y236Uy9szDvMFQpG6aWL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-02 at 11:41 +0200, Bastian Hecht wrote:
> changelog v3:
>=20
> Just a rebase on current l2-mtd.git.

Aiaiai says that your patch-set introduced several warnings, could you
please take a look:

---------------------------------------------------------------------------=
-----

Bisectability test results for configuration "l2_mackerel_defconfig,arm,arm=
-unknown-linux-gnueabi-"

Bisecability test passed

---------------------------------------------------------------------------=
-----

Successfully built configuration "l2_mackerel_defconfig,arm,arm-unknown-lin=
ux-gnueabi-", results:

--- before_patching.log
+++ after_patching.log
@@ @@
-drivers/mtd/nand/sh_flctl.c:264:30: warning: incorrect type in argument 1 =
(different address spaces) [sparse]
-drivers/mtd/nand/sh_flctl.c:264:30:    expected void const volatile [noder=
ef] <asn:2>*<noident> [sparse]
-drivers/mtd/nand/sh_flctl.c:264:30:    got void *fifo_addr [sparse]
+drivers/mtd/nand/sh_flctl.c:301:38: warning: incorrect type in argument 1 =
(different address spaces) [sparse]
+drivers/mtd/nand/sh_flctl.c:301:38:    expected void const volatile [noder=
ef] <asn:2>*<noident> [sparse]
+drivers/mtd/nand/sh_flctl.c:301:38:    got void *fifo_addr [sparse]
+drivers/mtd/nand/sh_flctl.c:326:28: warning: cast removes address space of=
 expression [sparse]
+drivers/mtd/nand/sh_flctl.c:331:17: warning: incorrect type in argument 1 =
(different address spaces) [sparse]
+drivers/mtd/nand/sh_flctl.c:331:17:    expected void const volatile [noder=
ef] <asn:2>*<noident> [sparse]
+drivers/mtd/nand/sh_flctl.c:331:17:    got void *fifo_addr [sparse]
+drivers/mtd/nand/sh_flctl.c:967 flctl_probe() warn: 'irq' was not released=
 on error [smatch]

---------------------------------------------------------------------------=
-----

--=20
Best Regards,
Artem Bityutskiy

--=-y236Uy9szDvMFQpG6aWL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPoQ6yAAoJECmIfjd9wqK0pfAQANIXrofRDS3R1saH/newX0Jj
BYyMoOeDxs/dWZQ8A26aimtBf8GI37ABv79BZ9y3SDSZ4mSZ0ktpUBYZebw8kZTr
6MZG3EeseqjDZKcIeycqWwV9Hzki32WsJFP0IXwzs6B5gWwg29sugHuVxTBqtmsg
1pn7QQLo6Jh4IWNq5ge25EOU+Fey3lu43gDqrpCeREzP7OeJoNZk8V4FxDJipcDL
MHFOYWdQGv6LKf2AaB5TC1wk2zSpAbPlGMcGMjP/peauGN1bLSeHeALaQ9WnSDOL
Wc66DPLPn13JO7I9hIPwxEemMR4DKI7YpgyeyFo2HHl6i969KvNjGhd+lG1L222u
AT5kDTuBtBDd3LYZfx5ayFagjjC9gqI1DOGZEpfYhT62kBJ68+0IxQQvGzcQES5C
K5mNwR6uYIr7THFU/UxgnnFBv17Z/8LfK88MbVGhbhNRZv8BA6iPBHdsrC+u11ne
MX8ErZhBQFtQwinNJbS6TnSVA2IeOG8UZEbfHK4cJR5ekyDkWRUg8CRtGhQ3HcXz
HY/z1jfOJ1XlCltazJaOXpiPwC8ubzULVXc+a7gRrATSc+Cr/opO9iUccQYa3vw4
auGt1Fuko2eXuVF38Nhd8rOnfCBmttig30KoFQ8LmTvUG9EVfxAEsnx2tG5WqeEi
WxP9DVSkHUskfTjxJcIk
=s41c
-----END PGP SIGNATURE-----

--=-y236Uy9szDvMFQpG6aWL--

