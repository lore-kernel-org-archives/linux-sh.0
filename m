From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Feb 2013 15:56:23 +0000
Subject: Re: [PATCH] sh-pfc: sh_pfc_probe() sizeof() fix
Message-Id: <20130214155623.GA26810@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130214122347.20778.10789.sendpatchset@w520>
In-Reply-To: <20130214122347.20778.10789.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 14, 2013 at 01:26:42PM +0100, Laurent Pinchart wrote:
> Hi Magnus,
> 
> Thanks for the patch.
> 
> On Thursday 14 February 2013 21:23:47 Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Fix sizeof() usage in sh-pfc/core.c to allocate space
> > for the full data structure instead of a pointer.
> 
> Oops :-)
> 
> This is v3.9 material. Simon, could you please take this and push it upstream 
> for v3.9 ?

Sure, will do.
