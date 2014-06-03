From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 03 Jun 2014 17:39:05 +0000
Subject: Re: [PATCH v3] iommu: Add driver for Renesas VMSA-compatible IPMMU
Message-Id: <1837932.hUVa08Puz4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1396435657-3922-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<538D55C2.3090209@renesas.com>
In-Reply-To: <538D55C2.3090209-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khiem Nguyen <khiem.nguyen.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

On Tuesday 03 June 2014 13:57:38 Khiem Nguyen wrote:
> Hi Laurent,
> 
> Thanks for the patch.
> 
> > +	if (!iommu_present(&platform_bus_type))
> > +		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
> 
> With this code, if error occurs, it's hidden.
> 
> I think it should be like below,
> 
> > +	ret = bus_set_iommu(&platform_bus_type, &ipmmu_ops);
> > +	if (ret < 0)
> > +		return ret;
> 
> In this case, if error occurs, -EBUSY is returned.
> It's easier for troubleshooting the issue.
> 
> How do you think ?

I agree that we have a problem, but the problem is broader than this. Only one 
IOMMU type can be associated with a given bus, so things will break as soon as 
we will compile multiple IOMMU drivers in a multiplatform kernel. I'd like to 
fix this properly, but it requires IOMMU framework changes, and thus time. In 
the meantime we could apply your proposed modification, but it needs an 
additional platform_driver_unregister() call in the bus_set_iommu() error 
path.

-- 
Regards,

Laurent Pinchart

