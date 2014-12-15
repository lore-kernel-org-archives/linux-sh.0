From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 15 Dec 2014 18:44:29 +0000
Subject: Re: [PATCH 10/10] ARM: shmobile: r8a7791: Add IPMMU DT nodes
Message-Id: <1521122.WC5DkGVrBt@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1418602429-11276-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CAMuHMdWtkk=Q=Mfcyz03LBzXMuBOr8BZGNyCsQb9bwDty-4OiQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWtkk=Q=Mfcyz03LBzXMuBOr8BZGNyCsQb9bwDty-4OiQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Geert,

On Monday 15 December 2014 14:07:52 Geert Uytterhoeven wrote:
> On Mon, Dec 15, 2014 at 1:13 AM, Laurent Pinchart wrote:
> > Add the seven IPMMU instances found in the r8a7791 to DT with a disabled
> > status.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> The addresses and interrupt numbers look OK to me.
> However, my comment about the "0x800" offset is still valid.
> Shouldn't we have two register blocks, and let the driver use only the
> second one?
> 
> If you ignore, feel free to add my
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

I don't want to ignore your comment, but I don't know what to do here :-/ The 
datasheet lacks detailed information about secure vs. non-secure mode and how 
the two register sets are supposed to interoperate and be handled by the 
operating system.

-- 
Regards,

Laurent Pinchart

