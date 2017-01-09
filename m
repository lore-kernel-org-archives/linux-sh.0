From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 09 Jan 2017 15:00:58 +0000
Subject: Re: [PATCH 01/21] sh: sh7724: Don't use a public mmc header for MMC_PROGRESS*
Message-Id: <CACRpkdaSzQHj0UC+bLO1DyTADCvPLZOLsJVJtVC+V83-udZeOw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-2-git-send-email-ulf.hansson@linaro.org>
In-Reply-To: <1483102054-1752-2-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The enum that specifies the MMC_PROGRESS* types, is a sh mmcif specific
> thing and has no relevance in a public mmc header. Currently it's used only
> by the sh romImage MMCIF boot, so let's instead define the enum in there
> and rename the types to MMCIF_* to show this.
>
> Cc: linux-sh@vger.kernel.org
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

As Simon notices: this also needs to delete <linux/mmc/boot.h>.

With that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
