From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 03 Dec 2013 09:34:36 +0000
Subject: Re: [PATCH 2/2] sh-pfc: Fix PINMUX_GPIO macro
Message-Id: <CACRpkdbwJFz+Af=XzHe=+N5WVPErJHutmMqP-VtOuPM9z53TZA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385430334-12141-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385430334-12141-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 26, 2013 at 2:45 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Commit 7cbb0e55e27e ("sh-pfc: Don't duplicate argument to PINMUX_GPIO
> macro") erronesouly modified the PINMUX_GPIO macro in a way that
> resulted in all pins being named "name". Fix the macro to name the pins
> correctly.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Or is this a regression I should apply for fixes?

Yours,
Linus Walleij
