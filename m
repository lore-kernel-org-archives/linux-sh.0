From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Mar 2015 01:15:12 +0000
Subject: Re: [PATCH v3 3/4] pinctrl: sh-pfc: Use reg_width instead of reg as sentinel
Message-Id: <CACRpkdZ6kG0hJ7dno=ecFXEAPzpCUF3kDtS55rBkNo7+R1wu-A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426154956-26583-1-git-send-email-geert+renesas@glider.be>
	<1426154956-26583-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426154956-26583-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, Mar 12, 2015 at 11:09 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> All other loops over sh_pfc_soc_info.data_regs[] use
> pinmux_data_reg.regwidth as the sentinel, which is safer as zero is
> never a valid regwidth value (reg could be zero if we start using it to
> store an offset).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v3:
>   - Add Acked-by,

Patch applied.

Yours,
Linus Walleij
