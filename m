From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Mar 2013 14:21:51 +0000
Subject: Re: [PATCH 21/25] sh-pfc: Implement generic pinconf support
Message-Id: <3667153.ER2TX2yWJO@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1363214384-3870-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363214384-3870-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

Thank you for the review.

On Thursday 14 March 2013 15:08:23 Linus Walleij wrote:
> On Wed, Mar 13, 2013 at 11:39 PM, Laurent Pinchart wrote:
> > The existing PFC pinconf implementation, tied to the PFC-specific pin
> > types, isn't used by drivers or boards. Replace it with the generic
> > pinconf types to implement bias (pull-up/down) setup. Other pin
> > configuration options can be implemented later if needed.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Basically really nice.
> 
> > +       select GENERIC_PINCONF
> 
> Especially that it uses generic pinconf.
> 
> >  static int sh_pfc_pinconf_get(struct pinctrl_dev *pctldev, unsigned _pin,
> >                               unsigned long *config)
> >  {
> >         struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> >         struct sh_pfc *pfc = pmx->pfc;
> > -       int idx = sh_pfc_get_pin_index(pfc, _pin);
> > -       struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
> > +       enum pin_config_param param = pinconf_to_config_param(*config);
> 
> This looks weird.
> 
> This function is supposed to read the hardware and return the configuration
> from the hardware registers, not to validate any configs? Especially the
> *config here should not be read, only written.

After reading the documentation I was still a bit at loss, so I've read 
several drivers to try and understand how pinconf get/set was supposed to 
operate. I have to confess that it didn't really clarify the situation :-)

My understanding of the pinconf API is that the config argument carries a 
parameter type and a value. When setting the parameter the situation is pretty 
clear, the parameter type and value are extracted from the config argument, 
and the value is written to the hardware based on the parameter type. If the 
type is not supported (for example PIN_CONFIG_INPUT_SCHMITT_ENABLE on a 
hardware that has no Schmitt triggers) the pin_config_set handler returns -
ENOTSUPP. If the value is not valid, it returns -EINVAL.

Getting parameters is a bit more confusing. I've understood the config 
argument as carrying the parameter type (with a 0 value) to be read. This is 
why my pin_config_get handler first checks whether the parameter type is 
supported and returns -ENOTSUPP if it isn't. Is that incorrect ? If *config is 
supposed to be written only, how does the driver know which parameter value to 
return ?

> > +       unsigned long flags;
> > +       unsigned int bias;
> > +
> > +       if (!sh_pfc_pinconf_validate(pfc, _pin, param))
> > +               return -ENOTSUPP;
> 
> This doesn't make any sense for the same reason.
> 
> > -       *config = cfg->type;
> > +       switch (param) {
> > +       case PIN_CONFIG_BIAS_DISABLE:
> > +       case PIN_CONFIG_BIAS_PULL_UP:
> > +       case PIN_CONFIG_BIAS_PULL_DOWN:
> > +               if (!pfc->info->ops || !pfc->info->ops->get_bias)
> > +                       return -ENOTSUPP;
> > +
> > +               spin_lock_irqsave(&pfc->lock, flags);
> > +               bias = pfc->info->ops->get_bias(pfc, _pin);
> > +               spin_unlock_irqrestore(&pfc->lock, flags);
> > +
> > +               if (bias != param)
> > +                       return -EINVAL;
> > +
> > +               *config = 0;
> 
> Zero? I don't get it...
> 
> Nominally you should do something like:
> *config = PIN_CONF_PACKED(param, arg);
> 
> here.

To be honest I wasn't sure about this either :-) What values are the 
PIN_CONFIG_BIAS_DISABLE, PIN_CONFIG_BIAS_PULL_UP and PIN_CONFIG_BIAS_PULL_DOWN 
parameters supposed to take ? For the PULL_UP and PULL_DOWN parameters I've 
seen mentions of the resistor value. A 0 value would then mean a short-circuit 
(or possibly just a default resistor value when the value isn't configurable 
and/or known). Returning PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 0) would 
mean that the pull-up is enabled. What should the driver then return to a 
pin_config_get(PIN_CONFIG_BIAS_PULL_UP) if the pull-up is disabled ?

> >  static const struct pinconf_ops sh_pfc_pinconf_ops = {
> > 
> > -       .pin_config_get         = sh_pfc_pinconf_get,
> > -       .pin_config_set         = sh_pfc_pinconf_set,
> > -       .pin_config_dbg_show    = sh_pfc_pinconf_dbg_show,
> > +       .is_generic                     = true,
> > +       .pin_config_get                 = sh_pfc_pinconf_get,
> > +       .pin_config_set                 = sh_pfc_pinconf_set,
> > +       .pin_config_group_set           = sh_pfc_pinconf_group_set,
> > +       .pin_config_config_dbg_show     = pinconf_generic_dump_config,
> > 
> >  };
> 
> So the docs for pin_config_get may need improvement if the intended usecase
> is not clear...

I think it's actually generic pinconf that lacks documentation. As you can see 
from my questions above there are many grey areas (at least to me :-)).

> It can be used for example from debugfs to display the current configuration
> of all pins.

-- 
Regards,

Laurent Pinchart

