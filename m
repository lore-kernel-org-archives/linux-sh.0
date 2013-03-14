From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Mar 2013 14:29:21 +0000
Subject: Re: [PATCH 21/25] sh-pfc: Implement generic pinconf support
Message-Id: <CACRpkdZaCx8CqQ1k=9E4-Z9Q1eUcJ1Hcm4N2T2gdPCx5HiU2kA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363214384-3870-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363214384-3870-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 14, 2013 at 3:21 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> After reading the documentation I was still a bit at loss, so I've read
> several drivers to try and understand how pinconf get/set was supposed to
> operate. I have to confess that it didn't really clarify the situation :-)

OK let's patch Documentation/pinctrl.txt as an outcome of this discussion.

> My understanding of the pinconf API is that the config argument carries a
> parameter type and a value. When setting the parameter the situation is pretty
> clear, the parameter type and value are extracted from the config argument,
> and the value is written to the hardware based on the parameter type. If the
> type is not supported (for example PIN_CONFIG_INPUT_SCHMITT_ENABLE on a
> hardware that has no Schmitt triggers) the pin_config_set handler returns -
> ENOTSUPP. If the value is not valid, it returns -EINVAL.

Yes.

> Getting parameters is a bit more confusing. I've understood the config
> argument as carrying the parameter type (with a 0 value) to be read. This is
> why my pin_config_get handler first checks whether the parameter type is
> supported and returns -ENOTSUPP if it isn't. Is that incorrect ? If *config is
> supposed to be written only, how does the driver know which parameter value to
> return ?

Oh damned, I was totally wrong, I thought we had designed it to be
a single call to get all the configurations, but indeed you are right,
for example in the debugfs code in pinconf-generic.c:pinconf_generic_dump_pin.

Mea culpa :-(

Acked-by: Linus Walleij <linus.walleij@linaro.org>

for this patch.

Yours,
Linus Walleij
