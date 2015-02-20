From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Feb 2015 10:04:55 +0000
Subject: Re: [PATCH] pinctrl: mediatek: Fix build error in Mediatek pinctrl driver.
Message-Id: <CACRpkdYNTT=qojYs8+vaXPFCSbHcUXJhzpWsM6Fga2erMKzPeQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423727771-24112-1-git-send-email-hongzhou.yang@mediatek.com>
In-Reply-To: <1423727771-24112-1-git-send-email-hongzhou.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 12, 2015 at 8:56 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> Since pinconf relate API changes in pinctrl devel branch, a build error happened.
> Send this small patch to fix it.
>
> ---
> Due to pinconf_generic_parse_dt_config() API changes in pinctrl devel branch,
> add one parameter to fix build error.
>
> Also fix warning:
> drivers/pinctrl/mediatek/pinctrl-mtk-common.c:718:3: warning: too many arguments for format [-Wformat-extra-args]
>       dev_err(&pdev->dev, "only support pins-are-numbered format\n", ret);
>       ^
>
> by removing extra parameter when calling dev_err in mtk_pctrl_init.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
