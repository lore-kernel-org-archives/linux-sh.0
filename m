From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 21 Dec 2015 03:53:32 +0000
Subject: Re: [PATCH/RFC 26/48] videodev2.h: Add request field to v4l2_pix_format_mplane
Message-Id: <2483596.RbRG4xoGDV@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <3030478.j1ZKoooRrc@avalon> <CAMuHMdU5ZRZyNwkKissXckvAWaD4osDYhCM7STw3L0wL_xgQnQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU5ZRZyNwkKissXckvAWaD4osDYhCM7STw3L0wL_xgQnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geert,

On Friday 18 December 2015 18:37:51 Geert Uytterhoeven wrote:
> On Fri, Dec 18, 2015 at 6:16 PM, Laurent Pinchart wrote:
> >> > @@ -1987,7 +1988,8 @@ struct v4l2_pix_format_mplane {
> >> >     __u8                            ycbcr_enc;
> >> >     __u8                            quantization;
> >> >     __u8                            xfer_func;
> >> > -   __u8                            reserved[7];
> >> > +   __u8                            reserved[3];
> >> > +   __u32                           request;
> >> 
> >> I think I mentioned this before: I feel uncomfortable using 4 bytes of
> >> the reserved fields when the request ID is limited to 16 bits anyway.
> > 
> > I'm still unsure whether request IDs should be 16 or 32 bits long. If we
> > go for 16 bits then I'll of course make this field a __u16.
> > 
> >> I would prefer a __u16 here. Also put the request field *before* the
> >> reserved array, not after.
> > 
> > The reserved array isn't aligned to a 32 bit (or even 16 bit) boundary. I
> > can put the request field before it, with a 8 bit hole before the field.
>
> There's no alignment at all due to:
>
> >> >  } __attribute__ ((packed));

Oops, indeed. Still, isn't it better to keep 16-bit or 32-bit values aligned 
to 16-bit or 32-bit boundaries ?

-- 
Regards,

Laurent Pinchart

