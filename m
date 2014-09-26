From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 26 Sep 2014 12:30:56 +0000
Subject: Re: [PATCH 10/12] video: Add ADV751[13] DT bindings documentation
Message-Id: <1464975.QfMrH1tcTG@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <7167797.cQ2LzKYS7F@avalon>
 <CAMuHMdXmaxmb0GgidM9LL7DhqHQXO3YfOdfpWv=zwHBN6T_UXA@mail.gmail.com>
In-Reply-To: <CAMuHMdXmaxmb0GgidM9LL7DhqHQXO3YfOdfpWv=zwHBN6T_UXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geert,

On Thursday 25 September 2014 12:10:59 Geert Uytterhoeven wrote:
> On Thu, Sep 25, 2014 at 11:57 AM, Laurent Pinchart wrote:
> > On Thursday 25 September 2014 09:06:46 Geert Uytterhoeven wrote:
> >> On Wed, Sep 24, 2014 at 10:04 PM, Laurent Pinchart
> >> 
> >> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> >> > +- adi,input-style: The input components arrangement variant (1, 2 or
> >> > 3).
> >> 
> >> What's the meaning of the numerical values 1, 2, and 3?
> >> 
> >> I found this code in "[PATCH 11/12] drm: Add adv7511 encoder driver":
> >> 
> >> +       input_style = config->input_style = 1 ? 2
> >> +                   : (config->input_style = 2 ? 1 : 3);
> >> 
> >> which didn't really help much ;-)
> >> 
> > :-)
> > 
> > The ADV751[13]W? datasheets document all the supported input formats.
> > They're split in categories, each of them having multiple variants called
> > styles. The styles are just numbered 1, 2 and 3 in the tables that
> > describe the formats, and there's a register field used to select a
> > style. For some reason style 1 maps to register value 2, style 2 to
> > register value 1, and style 3 to register value 3. Go figure...
> 
> Thanks, that explains it.
> 
> Then I suggest to reflect this in the binding:
> 
>     - adi,input-style: The input components arrangement variant (1, 2 or 3),
> as listed in the datasheet.
> 
> and in the code, e.g. by translating the values using a mapping array?

I'll document the property as

- adi,input-style: The input components arrangement variant (1, 2 or 3), as
  listed in the input format tables in the datasheet.

and modify the code to use an array as in

    /*
     * The input style values documented in the datasheet don't match the
     * hardware register field values :-(
     */
    static const unsigned int input_styles[4] = { 0, 2, 1, 3 };

    ...
    regmap_update_bits(adv7511->regmap, ADV7511_REG_VIDEO_INPUT_CFG1, 0x7e,
                       (color_depth << 4) |
                       (input_styles[config->input_style] << 2));

(config->input_style is validated when parsing DT).

-- 
Regards,

Laurent Pinchart

