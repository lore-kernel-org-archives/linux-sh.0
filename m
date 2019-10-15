From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Tue, 15 Oct 2019 08:05:52 +0000
Subject: Re: [PATCH] sh: use dma_to_phys() instead of dev->dma_pfn_offset
Message-Id: <453a9a954f4967a68a7023c8c79a39fdcb69254a.camel@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-LqhdFNFQbXFXXko83wzg"
List-Id: <linux-sh.vger.kernel.org>
References: <20191011165129.29655-1-nsaenzjulienne@suse.de>
         <20191015074354.GB3464@infradead.org>
In-Reply-To: <20191015074354.GB3464@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org


--=-LqhdFNFQbXFXXko83wzg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-15 at 00:43 -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2019 at 06:51:29PM +0200, Nicolas Saenz Julienne wrote:
> > It's more explicit and lets dma-direct handle the specifics of how to
> > translate addresses.
> >=20
> > On top of that get rid of warnings as, since the introduction of commit
> > 6fa1d28e38c ("sh: use generic dma_noncoherent_ops"), it's impossible fo=
r
> > the dev to be NULL.
>=20
> This looks ok, but the real answer is to switch sh to the generic
> dma remapping code.  I've been trying to get this included for about
> a year now, but never managed to get a reply from the sh maintainers.

I see, well I guess this one will get ignored too :)

> Here is the last one:
>=20
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sh-dma-re=
map

I'd be happy with your series too.

In case you're wondering why I want this: I'm interested in supporting mult=
iple
dma-ranges in DT. So I was looking at the amount of work needed to centrali=
ze
usage of dev->dma_pfn_offset. This one patch seemed trivial enough to send
right away.

Regards,
Nicolas


--=-LqhdFNFQbXFXXko83wzg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2lfeAACgkQlfZmHno8
x/7FnQf/fWogNvidITqlQcsKCGc7oeRASPSjW/lRMdE4n3pH/nBJe8zF9LqxNsZj
n0yCrXQfiJt9fVzHMLjWmi7vrC8/e7MQ94nqYnK9R1E9KPKnkriRFU0ux2ahlU8l
xXHa0Q0momOpZimYl5rR0rYVVi1nrhkRl8TUJn2WAAfO2X+z9r1O2LwWTAVmR6yL
wIG81FoN1wXzZShor97MX7RAivRQ5HwediXU6o1GOjsqRPl8K8YvCFDuTnXH6iGZ
7TvnaGzKy0flfbvihDOCUNCLYTIy01aq/lqxBDl0/O9yOuRwNjfD8GekckaOx3p6
GJk1+BKLk3RydGJXLzJn37JhXq2eqg==
=h442
-----END PGP SIGNATURE-----

--=-LqhdFNFQbXFXXko83wzg--
