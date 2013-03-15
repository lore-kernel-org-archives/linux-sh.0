From: Simon Horman <horms@verge.net.au>
Date: Fri, 15 Mar 2013 06:25:28 +0000
Subject: Re: [PATCH v4 00/88] PFC pinctrl functions for sh7372, sh73a0, r8a7740 and r8a7779
Message-Id: <20130315062527.GH11196@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1363215633-4264-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363215633-4264-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 14, 2013 at 03:01:48PM +0100, Laurent Pinchart wrote:
> On Thursday 14 March 2013 14:55:00 Linus Walleij wrote:
> > On Thu, Mar 14, 2013 at 2:39 PM, Laurent Pinchart wrote:
> > > [Me]
> > > 
> > >> I merged a patch like this only yesterday to my fixes branch.
> > >> 
> > >> commit bf4d7be57ba9040347065f48a60f895a254f6e28
> > >> Author: Sachin Kamat <sachin.kamat@linaro.org>
> > >> Date:   Wed Mar 13 17:13:46 2013 +0530
> > >> pinctrl: generic: Fix compilation error
> > > 
> > > Great, thank you. Is that patch present in a stable branch that Simon
> > > could merge ?
> > 
> > Yes the fixes branch in the pinctrl tree.
> 
> Thank you. Simon, it looks like we'll need another rebase :-/ Could you please 
> merge that branch into your tree and give me the name of the resulting branch 
> on which I'll rebase the PFC patches ?

Sure, I have merged Linus's fixes branch into pinmux-base in the renesas
tree and pushed it to kernel.org. It should be there in a few minutes.
For reference the head commit is:

commit 47f4e0c1c87f34bf1fc74b8935a37d229a147946
Merge: a9324f6 bf4d7be
Author: Simon Horman <horms+renesas@verge.net.au>
Date:   Fri Mar 15 07:16:28 2013 +0100

    Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl into pinmux-base

> > >> > @@ -365,7 +365,9 @@ static const struct pinconf_ops sh_pfc_pinconf_ops
> > >> > = {
> > >> > 
> > >> >         .pin_config_get                 = sh_pfc_pinconf_get,
> > >> >         .pin_config_set                 = sh_pfc_pinconf_set,
> > >> >         .pin_config_group_set           = sh_pfc_pinconf_group_set,
> > >> > 
> > >> > +#ifdef CONFIG_DEBUG_FS
> > >> > 
> > >> >         .pin_config_config_dbg_show     = pinconf_generic_dump_config,
> > >> > 
> > >> > +#endif
> > >> > 
> > >> >  };
> > >> 
> > >> Is that necessary? Well it makes it harder to do the wrong thing...
> > >> 
> > >> Can you send a separate patch like this?
> > > 
> > > With the above patch merged in your tree no modification to sh-pfc is
> > > needed anymore.
> > 
> > Which one? The one I already merge or the snippet right here
> > #ifdef:ing around the dbg_show thing?
> 
> The one you have already merged, sorry.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
