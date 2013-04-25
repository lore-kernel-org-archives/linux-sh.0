From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Apr 2013 13:27:57 +0000
Subject: Re: [PATCH v2 2/4] sh-pfc: sh73a0: Add VCCQ MC0 regulator
Message-Id: <CACRpkdbSOZfcSE3hDFCRON42W7v9mmC+nsCu3G5NoRRsCcJYbA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 25, 2013 at 12:00 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The sh73a0 has an internal power gate on the VCCQ power supply for the
> SDHI0 device that is controlled (for some strange reason) by a bit in a
> PFC register. This feature should be exposed as a regulator.
>
> As the same register is also used for pin control purposes there is no
> way to achieve atomic read/write sequences with a separate regulator
> driver. We thus need to implement the regulator here.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

As Mark is OK with it too:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
