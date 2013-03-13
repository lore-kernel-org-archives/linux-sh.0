From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Mar 2013 17:29:05 +0000
Subject: Re: [PATCH/RFC 04/12] sh-pfc: Make function GPIOs support optional
Message-Id: <CACRpkdZWVhTHSkcTZSa8nKxvCOPuFNEsCVThVAyQ5ce1ZJMUTw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 10, 2013 at 7:58 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The target is to get rid of function GPIOs completely. To reach this,
> make function GPIOs support optional by skipping the function GPIO chip
> registration if no function GPIOS are defined in SoC data.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
