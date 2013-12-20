From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Dec 2013 11:26:22 +0000
Subject: Re: [PATCH 1/4] pinctrl: sh-pfc: Constify enum_ids and var_field_width compound literals
Message-Id: <CACRpkdat58fTES_L84CDfE+7mmwqBYe2Nj-2FhK0thk7nMDWgA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387221917-15437-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387221917-15437-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 16, 2013 at 8:25 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The enum_ids and var_field_width fields of struct pinmux_data_reg and
> pinmux_cfg_reg are initialized using compound literals. Cast them to
> const to store them in .rodata.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Patch applied.

Yours,
Linus Walleij
