From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Dec 2008 22:50:45 +0000
Subject: Re: [PATCH 15/28] arch/sh: Drop return value from platform_driver remove functions
Message-Id: <20081210225044.GA2216@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0812101737120.21998@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.0812101737120.21998@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: dmitri.vorobiev@movial.fi, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Dec 10, 2008 at 05:37:35PM +0100, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> The return value of the remove function of a driver structure, and thus of
> a platform_driver structure, is ultimately ignored, and is thus
> unnecessary.  This patch removes the return value for the remove function
> stored in a platform_driver structure.  For the files in this patch, the
> return values are always 0.
> 
> A simplified version of the semantic patch that makes this change is as
> follows: (http://www.emn.fr/x-info/coccinelle/)
> 
Interesting definition of simplified ;-)

Applied, thanks.
