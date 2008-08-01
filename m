From: "Nobuhiro Iwamatsu" <iwamatsu@nigauri.org>
Date: Fri, 01 Aug 2008 03:48:27 +0000
Subject: Re: [PATCH] sh_eth Add SH7619 support
Message-Id: <29ab51dc0807312048hfa9cd88pb90d1a7520bb3f99@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878wvhtynu.wl%ysato@users.sourceforge.jp>
In-Reply-To: <878wvhtynu.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Jeff Garzik <jeff@garzik.org>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, netdev@vger.kernel.org, linux-sh@vger.kernel.org

Hi, Sato-san.

2008/8/1 Yoshinori Sato <ysato@users.sourceforge.jp>:
> SH7619 have same SH7710 ethernet controler.
> Add support for sh_eth driver.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>

<snip>

>
> diff --git a/drivers/net/sh_eth.h b/drivers/net/sh_eth.h
> index 45ad1b0..ca3cc5f 100644
> --- a/drivers/net/sh_eth.h
> +++ b/drivers/net/sh_eth.h
> @@ -143,10 +143,11 @@
>

<snip>

> +
> +/* CPU endian from/to EDMAC endian */
> +#if !defined(CONFIG_CPU_SUBTYPE_SH7619)
> +#define cpu_to_edmac(x) cpu_to_le32(x)
> +#define edmac_to_cpu(x) le32_to_cpu(x)
> +#else
> +#define cpu_to_edmac(x) cpu_to_be32(x)
> +#define edmac_to_cpu(x) be32_to_cpu(x)
> +#endif
> +
>  #endif
I think that this depends on an endian not CPU dependence.

Best regards,
 Nobuhiro
