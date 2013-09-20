From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Sep 2013 18:36:57 +0000
Subject: Re: [PATCH/RESEND 1/2] gpio: rcar: Remove #gpio-range-cells DT property usage
Message-Id: <CACRpkdZ4EaUVgYoMP6VMefZgE1T--5hh18RzupQLnbd0KpveAA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1378907462-19247-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1378907462-19247-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1378907462-19247-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 11, 2013 at 3:51 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Commit a1bc260bb5f5d95da854be7898202d788e94448d ("gpio: clean up
> gpio-ranges documentation") deprecated the #gpio-range-cells property.
> Replace its usage with a hardcoded value in the gpio-rcar driver.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Simon please take the whole set into the SH tree.

Yours,
Linus Walleij
