From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Jun 2014 00:34:55 +0000
Subject: Re: [PATCH 1/2] ARM: lager: enable i2c devices
Message-Id: <20140605003455.GD14471@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1392224674-5328-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392224674-5328-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 05, 2014 at 03:00:21AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 02/12/2014 08:04 PM, Ben Dooks wrote:
> 
> >Add i2c0, i2c1, i2c2 and i2c3 nodes to the Lager reference device tree as
> >these busses all have devices on them that can be probed even if they
> >are no drivers yet.
> 
> >Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
>    Hm, these patches seem to be pre-requisites for the Lager VIN patchset.
> Why haven't they been merged still?

I suspect I was waiting for Ben to address some review provided
(which requested minor changelog modifications) for the
series and then things slipped through the cracks.

I have now queued up the patches (after addressing the review item).
