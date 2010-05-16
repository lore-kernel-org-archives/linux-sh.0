From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: Sun, 16 May 2010 01:54:40 +0000
Subject: Re: [PATCH] media/IR: Add missing include file to rc-map.c
Message-Id: <4BEF5060.5050105@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201005051720.22617.PeterHuewe@gmx.de> <201005112042.14889.PeterHuewe@gmx.de> <20100514060240.GD12002@linux-sh.org> <201005141326.52099.PeterHuewe@gmx.de>
In-Reply-To: <201005141326.52099.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>
Cc: linux-next@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@ozlabs.org, David H?rdeman <david@hardeman.nu>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-mips@linux-mips.org, linux-m68k@lists.linux-m68k.org

Peter H=FCwe wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
>=20
> This patch adds a missing include linux/delay.h to prevent
> build failures[1-5]
>=20
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
> Forwarded to linux-next mailing list -=20
> breakage still exists in linux-next of 20100514 - please apply
>=20
> KernelVersion: linux-next-20100505

Sorry for not answer earlier. I was traveling. Anyway, this
patch got applied on May, 12:

http://git.kernel.org/?p=3Dlinux/kernel/git/mchehab/linux-next.git;a=3Dcomm=
itdiff;hJce7aa2998b2974948f1948a61a5d348ddae472

>=20
> References:
> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/2571452/
> [2] http://kisskb.ellerman.id.au/kisskb/buildresult/2571188/
> [3] http://kisskb.ellerman.id.au/kisskb/buildresult/2571479/
> [4] http://kisskb.ellerman.id.au/kisskb/buildresult/2571429/
> [5] http://kisskb.ellerman.id.au/kisskb/buildresult/2571432/
>=20
> drivers/media/IR/rc-map.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/media/IR/rc-map.c b/drivers/media/IR/rc-map.c
> index caf6a27..46a8f15 100644
> --- a/drivers/media/IR/rc-map.c
> +++ b/drivers/media/IR/rc-map.c
> @@ -14,6 +14,7 @@
> =20
>  #include <media/ir-core.h>
>  #include <linux/spinlock.h>
> +#include <linux/delay.h>
> =20
>  /* Used to handle IR raw handler extensions */
>  static LIST_HEAD(rc_map_list);


--=20

Cheers,
Mauro
