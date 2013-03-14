From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Mar 2013 08:18:46 +0000
Subject: Re: [PATCH 16/25] sh-pfc: Don't modify pinmux_data_reg SoC data
Message-Id: <CACRpkdbDKqf-mTZM5DbxooQU51FWzaeYRtCzXwdr2aCPz1UeFg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363214384-3870-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363214384-3870-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 13, 2013 at 11:39 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The pinmux_data_reg structure supplied in SoC data contains information
> about data registers. It's abused to store per-device mapped iomem and
> shadow values. Move those fields out of the pinmux_data_reg structure
> into the per-device sh_pfc_chip structure.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
