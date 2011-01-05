From: Chris Ball <cjb@laptop.org>
Date: Wed, 05 Jan 2011 22:57:03 +0000
Subject: Re: outstanding TMIO MMC patches
Message-Id: <20110105225703.GD13209@void.printf.net>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1012281211560.21647@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1012281211560.21647@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org

Hi Ian,

On Wed, Dec 29, 2010 at 12:32:13AM +0100, Guennadi Liakhovetski wrote:
> There are a number of outstanding tmio-mmc patches from Arnd Hannemann and 
> myself, many of them posted weeks ago. We really would like to have them 
> in 2.6.38. Would you have time to process them? Otherwise, could someone 
> else maybe apply them? Listed in the order, in which they should be 
> applied.

I've applied these to mmc-next, plus two more of Arnd's, since it looks 
like you don't have time for reviews at the moment.  Feel free to review
them before .38 releases; we can still make changes if necessary.  It'd
be great if you can retest on mmc-next with your HW, too.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
