From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Mar 2013 08:17:34 +0000
Subject: Re: [PATCH 14/25] sh-pfc: Don't map data registers individually
Message-Id: <CACRpkdbh-xT=RMVUCpdM4Qrz0+-TGR95EKE_naJCWOc95o7EDg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363214384-3870-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363214384-3870-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 13, 2013 at 11:39 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> All data registers are located in the same memory resource. Locate the
> mapped resource at initializat time and use it directly instead of
> computing a mapped address for each register. This gets rid of the
> mapped_reg field of the pinmux_data_reg structure.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
