From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2014 12:47:08 +0000
Subject: Re: [PATCH 2/7] pinctrl: pinconf-generic: Infer map type from DT property
Message-Id: <CACRpkdbOLMT1vfFg=CAU_VHdjxPWn_Ybso=+8Asp=mXhmNBRSA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-3-git-send-email-soren.brinkmann@xilinx.com>
In-Reply-To: <1415041531-15520-3-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 3, 2014 at 8:05 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> With the new 'groups' property, the DT parser can infer the map type
> from the fact whether 'pins' or 'groups' is used to specify the pin
> group to work on.
> To maintain backwards compatibitliy with current usage of the DT
> binding, this is only done when an invalid map type is passed to the
> parsing function.

So that is this:

> +               if (type = PIN_MAP_TYPE_INVALID)
> +                       type = PIN_MAP_TYPE_CONFIGS_GROUP;
> +               dt_pin_specifier = "groups";

This is just kludgy. There are only two kernel-internal users of this function,
refactor the function signature and change the other callers over instead,
patch the drivers.

Take this opportunity to add some kerneldoc above the
pinconf_generic_dt_subnode_to_map() and give the function a
reasonable signature.

BTW: this is just for config settings for groups right? Not for muxing
I hope?

Yours,
Linus Walleij
