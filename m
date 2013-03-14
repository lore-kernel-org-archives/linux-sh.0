From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Mar 2013 13:39:35 +0000
Subject: Re: [PATCH v4 00/88] PFC pinctrl functions for sh7372, sh73a0, r8a7740 and r8a7779
Message-Id: <3618543.7NdQnm2iZo@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1363215633-4264-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363215633-4264-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Thursday 14 March 2013 14:31:09 Linus Walleij wrote:
> On Thu, Mar 14, 2013 at 1:54 PM, Laurent Pinchart wrote:
> >> It seems like some Kconfig updates might be in order.
> > 
> > I see two ways to fix this but I'm not sure which one is best. The first
> > one handles the issue in the pinctrl core:
>
> And that is what we want to do.
> 
> > -#ifdef CONFIG_GENERIC_PINCONF
> > +#if defined(CONFIG_GENERIC_PINCONF) && defined (CONFIG_DEBUG_FS)
> 
> I merged a patch like this only yesterday to my fixes branch.
> 
> commit bf4d7be57ba9040347065f48a60f895a254f6e28
> Author: Sachin Kamat <sachin.kamat@linaro.org>
> Date:   Wed Mar 13 17:13:46 2013 +0530
> pinctrl: generic: Fix compilation error

Great, thank you. Is that patch present in a stable branch that Simon could 
merge ?

> > @@ -365,7 +365,9 @@ static const struct pinconf_ops sh_pfc_pinconf_ops = {
> >         .pin_config_get                 = sh_pfc_pinconf_get,
> >         .pin_config_set                 = sh_pfc_pinconf_set,
> >         .pin_config_group_set           = sh_pfc_pinconf_group_set,
> > +#ifdef CONFIG_DEBUG_FS
> >         .pin_config_config_dbg_show     = pinconf_generic_dump_config,
> > +#endif
> > 
> >  };
> 
> Is that necessary? Well it makes it harder to do the wrong thing...
> 
> Can you send a separate patch like this?

With the above patch merged in your tree no modification to sh-pfc is needed 
anymore.

-- 
Regards,

Laurent Pinchart

