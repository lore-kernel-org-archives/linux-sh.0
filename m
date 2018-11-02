From: jacopo mondi <jacopo@jmondi.org>
Date: Fri, 02 Nov 2018 07:52:45 +0000
Subject: Re: [PATCH resend] arch/sh: mach-kfr2r09: fix struct mtd_oob_ops build warning
Message-Id: <20181102075245.GR15991@w540>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3rzwkXnKuCXxoL5m"
List-Id: <linux-sh.vger.kernel.org>
References: <702f0a25-c63e-6912-4640-6ab0f00afbc7@infradead.org>
In-Reply-To: <702f0a25-c63e-6912-4640-6ab0f00afbc7@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>


--3rzwkXnKuCXxoL5m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Randy,
   thanks for the patch.

On Thu, Nov 01, 2018 at 04:38:30PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> arch/sh/boards/mach-kfr2r09/setup.c does not need to #include
> <mtd/onenand.h>, and doing so causes a build warning, so drop
> that header file.
>
> In file included from ../arch/sh/boards/mach-kfr2r09/setup.c:28:
> ../include/linux/mtd/onenand.h:225:12: warning: 'struct mtd_oob_ops' declared inside parameter list will not be visible outside of this definition or declaration
>      struct mtd_oob_ops *ops);
>
> Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")

Not sure if this is worth pointing out, but this commit only resorts
headers. The one introducing the warning is actually 33893d7aa.

I felt like reporting this, as introducing a "Fixes" line for that
commit too would help backporting maybe?

In any case:
Acked-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j

>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/sh/boards/mach-kfr2r09/setup.c |    1 -
>  1 file changed, 1 deletion(-)
>
> --- linux-next-20181101.orig/arch/sh/boards/mach-kfr2r09/setup.c
> +++ linux-next-20181101/arch/sh/boards/mach-kfr2r09/setup.c
> @@ -25,7 +25,6 @@
>  #include <linux/memblock.h>
>  #include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
> -#include <linux/mtd/onenand.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/platform_data/lv5207lp.h>
>  #include <linux/platform_device.h>
>
>

--3rzwkXnKuCXxoL5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJb3AJNAAoJEHI0Bo8WoVY8AsIQAJETDari2XU4nzfJKl9tbQxZ
KdRZxRp4fzLI5VfzlJWOjY2IK7VtSf2mJ3yd9lXcXAT8OmbuoXXaomtYBxKhlmKP
mMxNzOfhl7zn+UUOpN70XIaVtb791OA3TEB1Ohx15gUQj9wd7kB6g5V/coXgzdpP
e2lkpZ1x5yWdye3eJto0D7HBi2fXFj+zaElNhpg2l+CyfkuovspJUjeZ9bfRVisf
O+BwoeNNpP++U1KnS29YvonIU2b/dQfCl9sep3/kKF72IX8eQKWMR9fej4FXpEh4
0c8HLrfalc2dKJwQYlLeuCpSzMC0MDVviISKvsF/+OtMJsg3kCFx4oCyg1ZTTdT/
yMTDS2PjHa6OvBPnnDyel+qQSnPU8UkIfHCfyRxyZ55Nj/11cz2NKfgbliNeVbdb
bqxJFsnPeFDvhhbIjvX+ri6wUamcKD6jP1Fs8GRXrZYeAbbyKKAFs1ypZQKNuICh
YhWDvITQcQPoVdJcMY4E331lmI/4sQDku96oW9wDykw9gwVYI+NlbQsnLbuaY092
pkCENu6UO+az/uOzgx2ZZzTN80CaWXJrQOJ3UL00RDEEZzreAypLzws1s4AB0uPk
As+ozwwmlBJjuf4fFn2liyapFQgwBbe2EfQRSXF6dnassMghFhQc6vyHK0HOGm7Y
Y6ejWsgxCgB9fiW+AmqQ
=O2GC
-----END PGP SIGNATURE-----

--3rzwkXnKuCXxoL5m--
