From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 22 May 2010 07:45:46 +0000
Subject: Re: [PATCH 3/3] sh: add Video Output Unit (VOU) and AK8813 TV-encoder support to ms7724se
Message-Id: <20100522074545.GB17814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1003111124440.4385@axis700.grange> <Pine.LNX.4.64.1003111440300.4385@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1003111440300.4385@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <damm@opensource.se>

On Thu, Mar 11, 2010 at 02:45:00PM +0100, Guennadi Liakhovetski wrote:
> Add platform bindings, GPIO initialisation and allocation and AK8813 reset code
> to ms7724se.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Obviously depends on the previous two VOU and AK881x patches, sorry for 
> not marking those with "PATCH x/3" accordingly. Those two patches do not 
> depend upon each other and initially I wasn't sure I'd be able to clean up 
> this patch sufficiently for submission. Two 10us delays are pretty random, 
> maybe they can be optimised out completely. I just tried to reproduced the 
> reset procedure from the ak8813 datasheet, and it says nothing about the 
> duration of respective stages.
> 
>  arch/sh/boards/mach-se/7724/setup.c |   88 ++++++++++++++++++++++++++++++++---
>  1 files changed, 81 insertions(+), 7 deletions(-)
> 
Now that the other two patches are upstream, I've applied this.
