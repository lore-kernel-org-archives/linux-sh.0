From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 16 Oct 2015 15:06:27 +0000
Subject: Re: [PATCH 0/2] pinctrl: sh-pfc: Remove obsolete platform_device_id entries
Message-Id: <CACRpkdYP_NODbDEweLRksiJ9wmVPMewewm7rGiEfRueKCN0KDQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444213720-26770-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444213720-26770-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Oct 7, 2015 at 12:28 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Since the removal of the r8a7778 legacy SoC code in commit
> 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete setup code"),
> which is now in arm-soc/for-next, Renesas R-Car Gen1 SoCs are only
> supported in generic DT-only ARM multi-platform builds.
> The driver doesn't need to match platform devices by name anymore, hence
> this series removes the corresponding platform_device_id entries.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Add to your pull request...

Yours,
Linus Walleij
