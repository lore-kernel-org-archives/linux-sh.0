From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 13 Jan 2014 12:36:43 +0000
Subject: Re: [PATCH V2 6/8] spi: rspi: Add support for missing SPCR2 register
Message-Id: <52D3DDDB.309@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org> <1389522464-1569-7-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1389522464-1569-7-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Hello.

On 12-01-2014 14:27, Geert Uytterhoeven wrote:

> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

> Add support for RSPI variants lacking the RSPI Control Register 2, based on
> the SDK reference code. This is needed for RZ/A1H.

> The availability of this register is passed using platform data, defaulting
> to true for legacy RSPI. QSPI never has this register.

> If the register is not available, it should not be touched.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

    I believe such things should be done via different platform device IDs 
instead, not platform data.

WBR, Sergei

