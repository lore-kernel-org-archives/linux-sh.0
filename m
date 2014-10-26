From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 26 Oct 2014 13:13:36 +0000
Subject: Re: [PATCH v4 8/9] ARM: shmobile: koelsch-reference: Remove DU platform device
Message-Id: <3733861.rNreKO7l72@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414152241-5390-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414152241-5390-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the review.

On Friday 24 October 2014 14:38:42 Geert Uytterhoeven wrote:
> On Fri, Oct 24, 2014 at 2:04 PM, Laurent Pinchart
> 
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > --- a/arch/arm/mach-shmobile/board-koelsch-reference.c
> > +++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
> > 
> > -static void __init koelsch_add_standard_devices(void)
> > -{
> > -       shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
> 
> And that was the last user of shmobile_clk_workaround(), which can now be
> sent to the land of the dodo...

Good point. I'll add removal patches to the series.

> > -       of_platform_populate(NULL, of_default_bus_match_table, NULL,
> > NULL);
> > -
> > -       koelsch_add_du_device();
> > -}

-- 
Regards,

Laurent Pinchart

