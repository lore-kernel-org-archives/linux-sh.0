From: Greg KH <greg@kroah.com>
Date: Mon, 04 Feb 2008 05:29:00 +0000
Subject: Re: [PATCH] SH/Dreamcast - fix regressions, whitespace and memory
Message-Id: <20080204052900.GB7585@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1202068847.6262.7.camel@localhost.localdomain>
In-Reply-To: <1202068847.6262.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, Feb 03, 2008 at 08:00:47PM +0000, Adrian McMenamin wrote:
> From: Adrian McMenamin
> 
> This patch fixes the regression noted here:
> http://lkml.org/lkml/2008/1/26/189 as well as whitespace issues in the
> previous commit of this driver and the memory leaks noted here:
> http://lkml.org/lkml/2008/2/2/143 (as well as one or two other minor
> cleanups).

Which portion of the patch fixes the kobject WARN_ON()?

thanks,

greg k-h
