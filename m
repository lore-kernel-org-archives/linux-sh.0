From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 27 Jan 2015 08:55:22 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7794: alt: Enable ethernet controller
Message-Id: <1818612.14pAH37Kz1@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the review.

On Tuesday 27 January 2015 09:53:25 Geert Uytterhoeven wrote:
> On Tue, Jan 27, 2015 at 9:45 AM, Laurent Pinchart wrote:
> > Enable the ethernet controller for the Alt board. Pin muxing entries are
> > currently left out as r8a7794 pin control support isn't available yet.
> > We thus rely on the boot loader to configure ethernet pins for now.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Looks OK (I don't have an Alt, nor schematics).

I only have a block diagram, no detailed schematics. I have however 
successfully tested the patch on Magnus' Alt board. It might depends on 
particular DIP switch settings, but it should be good enough to start with.

> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

-- 
Regards,

Laurent Pinchart

