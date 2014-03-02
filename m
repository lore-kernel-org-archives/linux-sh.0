From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 02 Mar 2014 20:22:03 +0000
Subject: Re: [PATCH v2 28/40] clocksource: sh_tmu: Add index to struct sh_tmu_channel
Message-Id: <1616978.WRnLkMEibb@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1393603090-23144-29-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393603090-23144-29-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the review.

On Friday 28 February 2014 18:58:00 Geert Uytterhoeven wrote:
> On Fri, Feb 28, 2014 at 4:57 PM, Laurent Pinchart wrote:
> > +       /*
> > +        * The SH3 variant (SH770x, SH7705, SH7710 and SH7720) maps
> > channel
> > +        * registers blocks at base + 2 + 12 * index, while all other
> > variants
> > +        * map them at base + 4 + 12 * index. We can compute the index
> > with a
> > +        * single equation, the 2 bytes difference is hidden by the / 12.
> > +        */
> > +       ch->index = (cfg->channel_offset - 2) / 12;
> 
> The "- 2" is not needed, as 2 / 12 = 0 in integer arithmetic.

I'll fix that in v3.

-- 
Regards,

Laurent Pinchart

