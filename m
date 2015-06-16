From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 16 Jun 2015 10:57:03 +0000
Subject: Re: [PATCH 3/3] drm: rcar-du: Convert rcar_du_encoders_init_one() return value to 0/<0
Message-Id: <3606392.4dYiok7J5y@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1432652516-15085-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1432652516-15085-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdWYUnY82cFeeZePOqu3VwLP_gq95a0K4qDJLGx+utLWJQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWYUnY82cFeeZePOqu3VwLP_gq95a0K4qDJLGx+utLWJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-sh list <linux-sh@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>

Hi Geert,

On Tuesday 26 May 2015 21:24:03 Geert Uytterhoeven wrote:
> On Tue, May 26, 2015 at 5:01 PM, Laurent Pinchart wrote:
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> > @@ -640,14 +640,14 @@ static int rcar_du_encoders_init_one(struct
> > rcar_du_device *rcdu,
> >         of_node_put(connector);
> >         
> >         if (!ret)
> > -               return 1;
> > +               return 0;
> > 
> >         if (ret != -EPROBE_DEFER)
> >                 dev_warn(rcdu->dev,
> >                          "failed to initialize encoder %s (%d),
> >                          skipping\n",
> >                          encoder->full_name, ret);
> > 
> > -       return 0;
> > +       return ret;
> >  }
> 
> Perhaps just
> 
>         if (ret && ret != -EPROBE_DEFER)
>                 dev_warn(...);
> 
>        return ret;
> 
> ?

Good point. I'll fix that.

-- 
Regards,

Laurent Pinchart

