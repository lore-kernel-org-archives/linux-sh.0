From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Apr 2013 20:03:56 +0000
Subject: Re: [PATCH] sh-pfc: Remove dependency on GPIOLIB
Message-Id: <CACRpkdYE2_MZ=pFU-eonmkaAbdAOOMe4eJTcjxEfpQ=d8a4ycA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365516361-7544-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1365516361-7544-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 9, 2013 at 4:06 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Make GPIO support optional for platforms that don't support GPIOLIB.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Just guessing this needs to go into Simon's tree?

Tell me if I should apply it to the pinctrl tree.

Yours,
Linus Walleij
