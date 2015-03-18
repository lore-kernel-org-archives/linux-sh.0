From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Mar 2015 01:17:35 +0000
Subject: Re: [PATCH 1/2] pinctrl: sh-pfc: Remove emev2 platform_device_id entry
Message-Id: <CACRpkdYQu_kwc_t46X_gHp+aHbpwbc5dgqgvG=FCo4tZW1CqZQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425986080-26648-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425986080-26648-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Mar 10, 2015 at 12:14 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The emev2 platform is now DT-only, the driver doesn't need to match
> platform devices by name anymore. Remove the corresponding
> platform_device_id entry.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The emev2 platform never had pinctrl support for non-DT.

Patch applied with Laurent's ACK.

Yours,
Linus Walleij
