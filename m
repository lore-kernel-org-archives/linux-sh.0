From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Fri, 19 Oct 2012 05:57:12 +0000
Subject: Re: [PATCH v2 0/2] Add DMA and device tree support to the flash controller FLCTL
Message-Id: <1350626232.5769.318.camel@sauron.fi.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-UD6HZ1LU174miqDAaFzQ"
List-Id: <linux-sh.vger.kernel.org>
References: <1349776729-9311-1-git-send-email-hechtb@gmail.com>
 <1350473030.5769.137.camel@sauron.fi.intel.com>
 <CABYn4szACuH3LQ193VJj6E=J4q4Ye4E4O6cUgjB8jmQK6RRmpA@mail.gmail.com>
In-Reply-To: <CABYn4szACuH3LQ193VJj6E=J4q4Ye4E4O6cUgjB8jmQK6RRmpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--=-UD6HZ1LU174miqDAaFzQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-10-17 at 15:05 +0200, Bastian Hecht wrote:
> Hi Artem,
>=20
> > Hi, I used to be able to compile MTD stuff for mackerel board with the
> > defconfig attached, but now it fails with 3.7-rc1 with as error:
> >
> > /tmp/cc2Nr7AN.s: Error: bad immediate value for 8-bit offset (1024)
> >
> > It fails for dogc4.c, but if I disable DOCG4, it fails for other driver=
s
> > with a similar error.
> >
> > I've tried (arm) gcc 4.6.3 and the latest Linaro 4.7 build.
> >
> > Any idea? I did not dig this, is this a known issue? Could you try to
> > reproduce this in your setup?
> >
>=20
> I can reproduce the error with the following output:
> /tmp/ccYAbker.s: Assembler messages:
> /tmp/ccYAbker.s: Error: bad immediate value for 8-bit offset (2048)
> make[3]: *** [drivers/mtd/nand/docg4.o] Error 1
>=20
> The compiler version is: gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
> I usually use: gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) and
> can compile things without problems.

Yeah, a bug report would be great. I've switched to 4.4.1 and checked
your patches with aiaiai:

---------------------------------------------------------------------------=
-----

Successfully built configuration "arm-mackerel_defconfig,arm,arm-none-linux=
-gnueabi-", results:

--- before_patching.log
+++ after_patching.log
@@ @@
+drivers/mtd/nand/sh_flctl.c:1142 flctl_probe() warn: 'irq' was not release=
d on error [smatch]
+drivers/mtd/nand/sh_flctl.c:1142:2-8: ERROR: missing iounmap; ioremap on l=
ine 1117 and execution via conditional on line 1140 [coccinelle]
+drivers/mtd/nand/sh_flctl.c:164:25: warning: cast removes address space of=
 expression [sparse]
+drivers/mtd/nand/sh_flctl.c:181:25: warning: cast removes address space of=
 expression [sparse]
-drivers/mtd/nand/sh_flctl.c:311 write_fiforeg() Error invalid range 4096 t=
o -1 [smatch]
-drivers/mtd/nand/sh_flctl.c:317:17: warning: incorrect type in argument 2 =
(different address spaces) [sparse]
-drivers/mtd/nand/sh_flctl.c:317:17:    expected void volatile [noderef] <a=
sn:2>*addr [sparse]
-drivers/mtd/nand/sh_flctl.c:317:17:    got void *fifo_addr [sparse]
+drivers/mtd/nand/sh_flctl.c:469 write_fiforeg() Error invalid range 4096 t=
o -1 [smatch]
+drivers/mtd/nand/sh_flctl.c:485:17: warning: incorrect type in argument 2 =
(different address spaces) [sparse]
+drivers/mtd/nand/sh_flctl.c:485:17:    expected void volatile [noderef] <a=
sn:2>*addr [sparse]
+drivers/mtd/nand/sh_flctl.c:485:17:    got void *fifo_addr [sparse]

---------------------------------------------------------------------------=
-----


Best Regards,
Artem Bityutskiy

--=-UD6HZ1LU174miqDAaFzQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQgOu4AAoJECmIfjd9wqK0wRIQAIb61h3Z7Q5Wf0zZLztW/5x/
A5D4F/yBESXm+ItopQmMkM0sqNP2tkxAPD6LpBAEQtOznDm0WOLPeBn0lEDz1pEX
HhG2qIhqhG1UWG2n3/Swt4Gc3AU4B2LIvz1DEXPOYqgEeZjp5/UxlkrdxnuUyyoW
tv47nkrsPDc3QNucXUwKTZRB6RhqFr7xqKs6shqKd6PP8bXGyzg7UeVTvojHR3aK
HST5AbJ0PGmQEjsbxmjUXvm0VnUGJBwbZU181fyFBV9Inc/jY9kEDtXQdiQxuvh4
UztZCduwbP31+WeHnzgZeCFRc6W6ZX4Ypc8qUnAWBJOdJnJaDTpKsO11xIRx9++X
MLWsXhnwqAOXAdw3b4f4kXY0uWPAM7yd5onXdDqOas3WuB1kwZoFzitnmnXOARwF
DcFDB2hGcmsF1hvo9ITcEo8j9icx7udRZG/LIEiAuUmvmC5V9HvbYRFlkX/b/l0x
lXtG5D0Q+Yog3d5dJaQQhpC8DQCNJvR3d3/x3c5SNOts+0BN5m9jU99KPMlCNDJC
GPmWyFVumO5UK8A/IX7MeCe+rrLn09/QfBJFaG2AQtSDkbUjWXCJXTmFaZh8GFXN
f35MSPlXC+IKrDkTlCaBT6pwU0nu09r1duDCIu7PeshlGjOwo4Awfch6dcMjRa7E
XuCDIfTv2MIqvVa2v+NP
=3pt7
-----END PGP SIGNATURE-----

--=-UD6HZ1LU174miqDAaFzQ--

