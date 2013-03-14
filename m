From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Mar 2013 08:19:11 +0000
Subject: Re: [PATCH 17/25] sh-pfc: Don't modify sh_pfc_pin SoC data
Message-Id: <CACRpkdagvtHK6Nxv14ubv=UbqgWexcm4BOL7qQ_Y=mf_gnCOQw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363214384-3870-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363214384-3870-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 13, 2013 at 11:39 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The sh_pfc_pin structure supplied in SoC data contains information about
> pin configuration and name. It's abused to store GPIO data registers
> information and pin config type. Move those fields out of the
> pinmux_data_reg structure into the new sh_pfc_gpio_pin and
> sh_pfc_pin_config structures.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
