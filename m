From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Dec 2013 11:28:15 +0000
Subject: Re: [PATCH 3/4] pinctrl: sh-pfc: sh: Constify pins and cfg_regs arrays
Message-Id: <CACRpkdZxrr7NmunmaNg_SK8LA+yLJYdJfDbLDCDt7_o_ynVLag@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387221917-15437-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387221917-15437-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 16, 2013 at 8:25 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The arrays are never modified, declare them as const.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Patch applied.

Yours,
Linus Walleij
