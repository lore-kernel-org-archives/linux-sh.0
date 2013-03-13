From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Mar 2013 17:29:22 +0000
Subject: Re: [PATCH/RFC 05/12] sh-pfc: Make GPIO support optional
Message-Id: <CACRpkdZfvpnyV_zQ+HUcZ5o=X=AFffZsMU5tZ94vOztQqyxoQA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 10, 2013 at 7:58 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> When implemented as a separate IP block, GPIOs should be handled by a
> separate driver. To make this possible GPIO support needs to be optional
> in the sh-pfc driver.
>
> If no GPIO data registers are supplied in the SoC information structure
> skip registration of the gpiochip.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
