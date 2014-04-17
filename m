From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 17 Apr 2014 10:14:00 +0000
Subject: Re: [PATCH v3] iommu: Add driver for Renesas VMSA-compatible IPMMU
Message-Id: <3961471.IYYJh47THK@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1396435657-3922-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<69859225.EqNRcgoKS0@avalon> <20140409105703.GV13491@8bytes.org>
In-Reply-To: <20140409105703.GV13491-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Joerg,

On Wednesday 09 April 2014 12:57:03 Joerg Roedel wrote:
> On Wed, Apr 09, 2014 at 12:43:57PM +0200, Laurent Pinchart wrote:
> > On Wednesday 02 April 2014 12:47:37 Laurent Pinchart wrote:
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  drivers/iommu/Kconfig                    |   12 +
> > >  drivers/iommu/Makefile                   |    1 +
> > >  drivers/iommu/ipmmu-vmsa.c               | 1070 +++++++++++++++++++++++
> > >  include/linux/platform_data/ipmmu-vmsa.h |   24 +
> > >  4 files changed, 1107 insertions(+)
> > >  create mode 100644 drivers/iommu/ipmmu-vmsa.c
> > >  create mode 100644 include/linux/platform_data/ipmmu-vmsa.h
> > > 
> > > Joerg, could you please take this patch in your tree for v3.16 ?
> > 
> > Ping ?
> 
> I am looking into this when the merge window is over.

I think it's over now :-)

-- 
Regards,

Laurent Pinchart

