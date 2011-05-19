From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 May 2011 00:52:44 +0000
Subject: Re: [PATCH 5/6] fbdev: sh_mobile_meram: Add clock enable/disble hooks
Message-Id: <BANLkTikXCN3zGbi_s2pxoanB+d3WwtX0ww@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1305717011-20742-6-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1305717011-20742-6-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, May 18, 2011 at 8:10 PM, Damian Hobson-Garcia
<dhobsong@igel.co.jp> wrote:
> Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
> ---
> =A0drivers/video/sh_mobile_meram.c | =A0 27 +++++++++++++++++++++++++++
> =A0include/video/sh_mobile_meram.h | =A0 =A06 ++++++
> =A02 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_me=
ram.c
> index 9170c82..5e4ce98 100644
> --- a/drivers/video/sh_mobile_meram.c
> +++ b/drivers/video/sh_mobile_meram.c
> @@ -12,6 +12,7 @@
> =A0#include <linux/kernel.h>
> =A0#include <linux/module.h>
> =A0#include <linux/device.h>
> +#include <linux/pm_runtime.h>
> =A0#include <linux/io.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/platform_device.h>
> @@ -460,11 +461,33 @@ static int sh_mobile_meram_update(struct sh_mobile_=
meram_info *pdata,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +int sh_mobile_meram_clk_on(struct sh_mobile_meram_info *pdata)
> +{
> + =A0 =A0 =A0 if (!pdata || !pdata->pdev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 dev_dbg(&pdata->pdev->dev, "Enabling sh_mobile_meram clock.=
");
> + =A0 =A0 =A0 pm_runtime_get(&pdata->pdev->dev);

This should be pm_runtime_get_sync() to force block until the clock is enab=
led.

> diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_me=
ram.h
> index af602d6..3605874 100644
> --- a/include/video/sh_mobile_meram.h
> +++ b/include/video/sh_mobile_meram.h
> @@ -63,6 +63,12 @@ struct sh_mobile_meram_ops {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long base=
_addr_c,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long *icb=
_addr_y,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long *icb=
_addr_c);
> +
> + =A0 =A0 =A0 /* enable meram clock */
> + =A0 =A0 =A0 int (*meram_clk_on)(struct sh_mobile_meram_info *meram_dev);
> +
> + =A0 =A0 =A0 /* disable meram clock */
> + =A0 =A0 =A0 int (*meram_clk_off)(struct sh_mobile_meram_info *meram_dev=
);

Hm, we need more than just clock control. Runtime PM is used for both
clock and power domain control. This means that after pm_runtime_put()
the power to the MERAM may be turned off. So you probably want to add
some context save/restore code to make sure the MERAM settings are
re-initialized after power-up. At this point there are no patches
upstream for this, but I think we should give it a try after
2.6.40-rc1 or rc2 is out.

Thanks,

/ magnus
