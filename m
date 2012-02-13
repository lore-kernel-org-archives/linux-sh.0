From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 13 Feb 2012 12:19:36 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: (cosmetic) simplify list operations
Message-Id: <Pine.LNX.4.64.1202131317390.8277@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1202092313560.18719@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1202092313560.18719@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 13 Feb 2012, Felipe Balbi wrote:

> On Thu, Feb 09, 2012 at 11:17:47PM +0100, Guennadi Liakhovetski wrote:
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> if (patch_has_no_commit_log(path)) {
> 	kfree(patch);
> 	continue;
> }

It is a common practice to omit a commit log in trivial patches, where the 
subject says it all, just look through git log. IMHO this is one of those 
cases - what else can you add to the statement in subj?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
