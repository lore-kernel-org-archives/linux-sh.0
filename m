From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Mar 2013 17:21:59 +0000
Subject: Re: [PATCH/RFC 02/12] gpio-rcar: Add pinctrl support
Message-Id: <CACRpkdZBROFhk7xoeaWCC87xvhpzdQ9wcrk-ZkJG7_Q9FP2fAg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 10, 2013 at 7:58 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Register the GPIO pin range, and request and free GPIO pins using the
> pinctrl API.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Looks good.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

This requires that the Rcar driver is finalized first tho I guess.

Yours,
Linus Walleij
