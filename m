From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Mon, 17 Oct 2011 02:19:37 +0000
Subject: Re: [PATCH 05/21] sh: drop unused Kconfig symbol
Message-Id: <CABMQnVKZjCC7Qjg+8NRQTwekdxKHjWG0=2ceSacvtEfuD9Qp1w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1318595280.6132.61.camel@x61.thuisdomein>
In-Reply-To: <1318595280.6132.61.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I tested with this patch. I didn't have any problem.

Tested-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

2011/10/14 Paul Bolle <pebolle@tiscali.nl>:
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> =A0arch/sh/Kconfig | =A0 =A04 ----
> =A01 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index ff9177c..2d39594 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -101,10 +101,6 @@ config GENERIC_LOCKBREAK
> =A0 =A0 =A0 =A0def_bool y
> =A0 =A0 =A0 =A0depends on SMP && PREEMPT
>
> -config SYS_SUPPORTS_PM
> - =A0 =A0 =A0 bool
> - =A0 =A0 =A0 depends on !SMP
> -
> =A0config ARCH_SUSPEND_POSSIBLE
> =A0 =A0 =A0 =A0def_bool n
>
> --
> 1.7.4.4
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Nobuhiro Iwamatsu
