From: Joerg Roedel <joro@8bytes.org>
Date: Tue, 13 May 2014 22:00:23 +0000
Subject: Re: [PATCH v3] iommu: Add driver for Renesas VMSA-compatible IPMMU
Message-Id: <20140513220023.GE23770@8bytes.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1396435657-3922-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<20140513175529.GD23770@8bytes.org> <2227683.61UxrJHGnf@avalon>
In-Reply-To: <2227683.61UxrJHGnf@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, May 13, 2014 at 11:04:10PM +0200, Laurent Pinchart wrote:
> > Isn't this the same as ipmmu_tlb_invalidate()?
> 
> ipmmu_tlb_invalidate() performs a read-update-write operation on the IMCTR 
> register to set the FLUSH bit without modifying the other bits, while this 
> function writes the FLUSH bit and sets all other bits (including the enable 
> bit) to zero. The difference is thus important.

Ah ok, I've seen that, but wasn't aware that it makes a difference.

> > Why not? This is something the IOMMU-API basically supports (multiple
> > devices behind different IOMMUs in the same domain). Can't you just use
> > the same page-table for different IOMMUs?
> 
> I might be able to (I'll need to check first though), but I don't really see 
> what the use cases for sharing a common page table between separate IOMMUs 
> would be. Could you please elaborate a bit ? Given that we're getting close to 
> the v3.16 merge window, would it be acceptable to fix (if needed) that as a 
> follow-up patch, as the driver is already usable as-is ?

The typical use-case is device-assignment in KVM, when you want to
assign multiple devices to the same guest it is desireable to only have
one domain with one page-table.
At least this is where this requirement comes from in the IOMMU-API, and
I like the IOMMU drivers to be consistent in their implementation of the
API.

I think given that otherwise the code looks good overall it is ok if you
do this as a follow-on patch to this one. I can put it in my tree for
the time being so that you can make a patch against the feature branch.


	Joerg


