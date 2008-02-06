From: Greg KH <greg@kroah.com>
Date: Wed, 06 Feb 2008 23:59:40 +0000
Subject: Re: [PATCH 2/2] - SH/Dreamcast - fix maple bus bugs
Message-Id: <20080206235940.GA16116@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1202337981.6162.8.camel@localhost.localdomain> <1202338431.6162.15.camel@localhost.localdomain> <20080206230127.GA9614@kroah.com> <1202339114.6162.17.camel@localhost.localdomain> <20080206232349.GA15654@kroah.com> <1202341881.6162.22.camel@localhost.localdomain>
In-Reply-To: <1202341881.6162.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@users.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Wed, Feb 06, 2008 at 11:51:21PM +0000, Adrian McMenamin wrote:
> Replacement second-in-series patch:
> 
> This patch fixes up memory leaks and, by delaying initialisation, makes
> device detection more robust.
> 
> It also makes clearer the difference between struct maple_device and
> struct device, as well as cleaning up the interrupt request code
> (without changing its function in any way).
> 
> Also now removes redundant registration checking.

Thanks for changing this.

greg k-h
