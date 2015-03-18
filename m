From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Mar 2015 01:19:21 +0000
Subject: Re: [PATCH 2/2] pinctrl: sh-pfc: Remove r8a7790 platform_device_id entry
Message-Id: <CACRpkdZHMjCjB91EFXpzgepErwqrigfjcve2MHte1dV1wuqzpQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425986080-26648-1-git-send-email-geert+renesas@glider.be>
	<1425986080-26648-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425986080-26648-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Mar 10, 2015 at 12:14 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The r8a7790 platform is now DT-only, the driver doesn't need to match
> platform devices by name anymore. Remove the corresponding
> platform_device_id entry.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The r8a7790 platform is DT-only since v4.0-rc1.

Patch applied with Laurent's ACK.

Yours,
Linus Walleij
