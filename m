From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 10 Feb 2015 22:32:21 +0000
Subject: Re: [PATCH] sh-pfc: add R8A7794 PFC support
Message-Id: <54DA86F5.5050208@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5105352.KV6seE7I1V@wasted.cogentembedded.com>
In-Reply-To: <5105352.KV6seE7I1V-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

On 02/11/2015 01:25 AM, Sergei Shtylyov wrote:

> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

> Add PFC support for  the  R8A7794 SoC  including pin groups for some on-chip
> devices such as ETH, I2C, INTC, MSIOF, QSPI, [H]SCIF...

> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> [Sergei: squashed together several patches, fixed the MLB_CLK typo, added IRQ4..
> IRQ9 pin groups,  fixed IRQn comments, added ETH B pin group names, removed
> stray new line and fixed typos in the  comments in the pinmux_config_regs[]
> initializer, added reasonable and removed unreasonable copyrights, modified
> the bindings document, renamed, added changelog.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

    Oops, forgot to rebase to the 'linux-pinctrl' repo's 'devel' branch 
(should I use some other?), and the patch doesn't apply there. Please ignore.

WBR, Sergei

