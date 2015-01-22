From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Jan 2015 21:50:41 +0000
Subject: Re: [PATCH v2 1/4] sh-pfc: add macro to define pinmux without function
Message-Id: <1580306.72ms5WNCEt@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1421583604-27256-1-git-send-email-niso@kth.se> <1421583604-27256-2-git-send-email-niso@kth.se>
In-Reply-To: <1421583604-27256-2-git-send-email-niso-UNjuZkX4dYU@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niso-UNjuZkX4dYU@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Hi Niklas,

Thank you for the patch.

On Sunday 18 January 2015 13:20:01 Niklas S=F6derlund wrote:
> Used to define pinmux configurations where the pinmux function have no
> representation in the configuration registers but instead solely depends
> on a group selection.
>=20
> Signed-off-by: Niklas S=F6derlund <niso@kth.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pinctrl/sh-pfc/sh_pfc.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index 5b72831..c837286 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -167,6 +167,8 @@ struct sh_pfc_soc_info {
>  	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ipsr)
>  #define PINMUX_IPSR_NOGM(ispr, fn, ms)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ms)
> +#define PINMUX_IPSR_NOFN(ipsr, fn, ms)					\
> +	PINMUX_DATA(fn##_MARK, FN_##ipsr, FN_##ms)
>  #define PINMUX_IPSR_MSEL(ipsr, fn, ms)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ipsr, FN_##ms)
>  #define PINMUX_IPSR_MODSEL_DATA(ipsr, fn, ms)				\

--=20
Regards,

Laurent Pinchart

