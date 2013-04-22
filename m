From: Simon Horman <horms@verge.net.au>
Date: Mon, 22 Apr 2013 03:45:54 +0000
Subject: Re: [PATCH 1/8] ARM: shmobile:Marzen: move USB EHCI, OHCI, and PHY devices to R8A7779 code
Message-Id: <20130422034554.GI15680@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201304050257.00799.sergei.shtylyov@cogentembedded.com>
 <20130418154425.GZ14496@n2100.arm.linux.org.uk>
 <5170301B.3030306@cogentembedded.com>
 <20130419021755.GF25718@verge.net.au>
 <51712E2E.8040105@cogentembedded.com>
In-Reply-To: <51712E2E.8040105@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Apr 19, 2013 at 03:44:46PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 19-04-2013 6:17, Simon Horman wrote:
> 
> >>>>+/* USB PHY */
> >>>>+static struct resource usb_phy_resources[] = {
> >>>>+	[0] = {
> >>>>+		.start		= 0xffe70000,
> >>>>+		.end		= 0xffe70900 - 1,
> >>>>+		.flags		= IORESOURCE_MEM,
> >>>>+	},
> >>>>+	[1] = {
> >>>>+		.start		= 0xfff70000,
> >>>>+		.end		= 0xfff70900 - 1,
> >>>>+		.flags		= IORESOURCE_MEM,
> >>>>+	},
> 
> >>>Please consider using the macros for these initialisers.
> 
> >>    I'm just moving the code as is here. The destination file still
> >>uses old style initializers, and probably needs the wholesale
> >>conversion patch in the future.
> 
> >My preference is for you to either convert these users in this patch or
> >provide a patch that makes a wholesale conversion.
> 
>    I'll try to do the latter but my load is currently very high, so that
> may take some time.

Thanks. In the same vein I have posted the following patch to
convert the sh73a0 SoC to use the macros.

"[PATCH] ARM: shmobile: sh73a0: Use IORESOURCE_MEM_* everywhere"
