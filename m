From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Apr 2014 14:09:04 +0000
Subject: Re: [PATCH] sh-pfc: r8a7790: Fix definition of IPSR5
Message-Id: <CACRpkdYy_fGfm-mj122aqAELBBew1Af0Q=OHP0KWxkeg1uGbyw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398180483-10651-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1398180483-10651-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Guido Piasenza <gpiasenza@soft-in.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Apr 22, 2014 at 5:28 PM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:

> From: Guido Piasenza <gpiasenza@soft-in.com>
>
> The extra entry in the table makes SCIFA0_B, and all peripherals after it, fail.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Patch applied for fixes with Lauren's additional fixup moving the define one
line up.

Yours,
Linus Walleij
