From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 07 Feb 2008 02:35:23 +0000
Subject: Re: [PATCH 1/2] - SH/Dreamcast - fix maple bus bugs
Message-Id: <20080207023523.GE13945@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1202337981.6162.8.camel@localhost.localdomain>
In-Reply-To: <1202337981.6162.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, Greg KH <greg@kroah.com>

On Wed, Feb 06, 2008 at 10:46:21PM +0000, Adrian McMenamin wrote:
> This patch is fundamentally about fixing up the whitespace problems introduced by my previous patch (that brought the code into mainline). A second patch will follow that will fix memory leaks. The two need to be applied sequentially.
> 
Please do not linewrap, this ends up going directly in to the commit.

> Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> 
Signed-off-by, please.

Also, please use a more helpful subject. Something like:
'maple: <short description of meaningful change>'. I've had to make
something up arbitrarily for this entire series based off of your
comments.

After some munging, git-am finally took it, so the series is now applied.
