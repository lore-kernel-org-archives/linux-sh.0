From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 07 Oct 2015 11:05:47 +0000
Subject: Re: [PATCH 0/2] pinctrl: sh-pfc: Remove obsolete platform_device_id entries
Message-Id: <2945124.tDacv8Sypm@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1444213720-26770-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444213720-26770-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patches.

On Wednesday 07 October 2015 12:28:38 Geert Uytterhoeven wrote:
> 	Hi Linus, Laurent,
> 
> Since the removal of the r8a7778 legacy SoC code in commit
> 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete setup code"),
> which is now in arm-soc/for-next, Renesas R-Car Gen1 SoCs are only
> supported in generic DT-only ARM multi-platform builds.
> The driver doesn't need to match platform devices by name anymore, hence
> this series removes the corresponding platform_device_id entries.
> 
> Geert Uytterhoeven (2):
>   pinctrl: sh-pfc: Remove obsolete r8a7779 platform_device_id entry
>   pinctrl: sh-pfc: Remove obsolete r8a7778 platform_device_id entry

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  drivers/pinctrl/sh-pfc/core.c | 6 ------
>  1 file changed, 6 deletions(-)

-- 
Regards,

Laurent Pinchart

