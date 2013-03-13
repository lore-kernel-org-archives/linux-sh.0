From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Mar 2013 17:41:42 +0000
Subject: Re: [PATCH/RFC 09/12] sh-pfc: r8a7779: Don't use GPIO enum entries
Message-Id: <CACRpkdYHRMhUR64DA9aJnHvi2b8ROUyPgss=6xm_Hwv6PJW1jA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 10, 2013 at 7:58 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Refactor the GPIO macro magic to use GPIO numbers directly instead of
> the GPIO_GP_x_y enum entries. This will allow removing the GPIO enum
> entries from the mach/r8a7779.h header.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Much more readable.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
