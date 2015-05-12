From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 12 May 2015 07:26:53 +0000
Subject: Re: [PATCH 1/2] pinctrl: sh-pfc: r8a73a4: Remove obsolete multi-platform check
Message-Id: <CACRpkdZZ_=x7=2Ae9VPAo6dPvD2D_2MUDwNjCF-jxSp075X1hA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430216072-31412-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430216072-31412-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, Apr 28, 2015 at 12:14 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> As of commit 9d07d414d4c33d86 ("ARM: shmobile: r8a73a4: ape6evm: Remove
> legacy platform"), r8a73a4 is only supported in generic ARM
> multi-platform builds.  Hence CONFIG_ARCH_MULTIPLATFORM is always set,
> and the check can be removed.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on Simon's branch r8a73a4-ccf-and-multiplatform-for-v4.1

I guess I can't merge it to pinctrl then and Simon will take it?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
