From: Greg KH <greg@kroah.com>
Date: Fri, 03 Dec 2010 20:13:50 +0000
Subject: Re: [PATCH] SuperH on-chip EHCI glue, v2
Message-Id: <20101203201350.GB17651@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20101201091357.GA2982@linux-sh.org>
In-Reply-To: <20101201091357.GA2982@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 01, 2010 at 06:13:57PM +0900, Paul Mundt wrote:
> This is a simple patch series for adding EHCI glue for the SuperH on-chip
> controller. It's largely modelled after the ohci-sh driver with clock
> management added on top, which I plan to move out to be shared between
> the two like Octeon presently does in a future patch -- this just hasn't
> been done yet since I need to go through and audit all of the SH OHCI
> users first.
> 
> As before, if you don't have any issues with the series then you can feel
> free to pull the topic branch in to one of your trees as-is, or I can
> merge it via the SH tree (I don't have anything that depends on it, so
> I'm fine with whatever you prefer).

I've pulled this into my -next branch and pushed it out, so you don't
have to worry about it anymore.

thanks,

greg k-h
