From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Jun 2013 09:35:05 +0000
Subject: Re: [PATCH] sh-pfc: Guard DT parsing with #ifdef CONFIG_OF
Message-Id: <CACRpkdY+a5GzvfDd+eqrSf_XkR0CGmgz+V94wOxRit7Wc+vCDA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1371641162-18833-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1371641162-18833-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 19, 2013 at 1:26 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Fix a compilation error caused by pinconf_generic_parse_dt_config() not
> being defined on !CONFIG_OF platforms by guarding the whole DT node
> parsing code with #ifdef CONFIG_OF.
>
> Defining a pinconf_generic_parse_dt_config() on !CONFIG_OF would have
> been possible as well, but would have resulted in a larger code size on
> !CONFIG_OF platforms (such as arch/sh).
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Patch applied with Simon's review tag.

Thanks,
Linus Walleij
