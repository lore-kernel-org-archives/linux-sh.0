From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 24 Feb 2011 08:16:08 +0000
Subject: Re: [PATCH] usb: add EHCI and OHCI support for SH7757
Message-Id: <w3p62s9c0fr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D660C04.9070800@renesas.com>
In-Reply-To: <4D660C04.9070800@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Shimoda san

> -#ifdef CONFIG_CPU_SUBTYPE_SH7786
> +#if defined(CONFIG_CPU_SUBTYPE_SH7757) || \
> +    defined(CONFIG_CPU_SUBTYPE_SH7785)

Is this miss ?
you remove 7786
and add    7785 ?
              ~

Best regards
--
Kuninori Morimoto
 
