From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 13 Apr 2020 22:08:07 +0000
Subject: Re: [PATCH] sh: mm: Fix build error
Message-Id: <20200414080807.78ac80d0@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/TE+C4ztpmHm5MtnELXTQ1RR"
List-Id: <linux-sh.vger.kernel.org>
References: <20200413161542.78700-1-linux@roeck-us.net>
In-Reply-To: <20200413161542.78700-1-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>

--Sig_/TE+C4ztpmHm5MtnELXTQ1RR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, 13 Apr 2020 09:15:42 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
>   415 |  if (WARN_ON_ONCE(params->pgprot.pgprot !=3D PAGE_KERNEL.pgprot)
>       |     ^
> arch/sh/mm/init.c:424:1: error: expected expression before '}' token
>   424 | }
>=20
> Obviously never even compile tested.
>=20
> Fixes: a332976e0184 ("mm/memory_hotplug: add pgprot_t to mhp_params")
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/sh/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index b9de2d4fa57e..8d2a68aea1fc 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -412,7 +412,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	unsigned long nr_pages =3D size >> PAGE_SHIFT;
>  	int ret;
> =20
> -	if (WARN_ON_ONCE(params->pgprot.pgprot !=3D PAGE_KERNEL.pgprot)
> +	if (WARN_ON_ONCE(params->pgprot.pgprot !=3D PAGE_KERNEL.pgprot))
>  		return -EINVAL;
> =20
>  	/* We only have ZONE_NORMAL, so this is easy.. */
> --=20
> 2.17.1
>=20

I'll put this in my fixes tree until someone else picks it up.  Now
that the patch has reached Linus' tree (and its SHA1 is stable), the
Fixes line should be

Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")

--=20
Cheers,
Stephen Rothwell

--Sig_/TE+C4ztpmHm5MtnELXTQ1RR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6U4scACgkQAVBC80lX
0GzuaggAiunNmiGzWHsiJnhwckuvgfzuWDgnMD1AlVndH55MC0HoiVLjhi0HzjHn
ISkQ50OgghtXu1p5lxBpUQc4xmyDV2pvo408xOf6Oufd8V2S23DEMZR3wQdIqNCu
8Uk34qbrdPRqjG/eZb0J9J5u3xQ1BOwZnZWG2MsMQ/tBLJQ4BBcQ2ShL9vlhLPJQ
ivKFnNEDwGgFEcyTCMDhWqnoZqVMpEzGfD3F/HVii8ChhaNw2ctMhJ1awG8W1efK
mWABEU/bhLog84txiMICSRlPiJFT8hcfr5PsIF7P6fbCsh55alXLUh4j33ycOCEX
sUCnljlP3VbfgBEIBxy/o+7gkU8N2w==
=D2Bg
-----END PGP SIGNATURE-----

--Sig_/TE+C4ztpmHm5MtnELXTQ1RR--
