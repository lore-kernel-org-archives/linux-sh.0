From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Mar 2013 08:19:40 +0000
Subject: Re: [PATCH 18/25] sh-pfc: Remove configuration dry-run and free
Message-Id: <CACRpkdYgwAbsJSXXDgTXh=S6_D3LPFrMqGExsMN9UPhVfwC-Ng@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363214384-3870-19-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363214384-3870-19-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 13, 2013 at 11:39 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The purpose of the dry-run is to ensure that a pin about to be
> configured isn't in use. However, the current implementation is a no-op.
> This proves that the dry-run isn't essential. Remove it.
>
> Freeing configuration then becomes a no-op as well. Remove it.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
