From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Nov 2015 02:16:28 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: alt: Correct scif2 pfc
Message-Id: <20151124021628.GA20338@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1448263004-14548-1-git-send-email-horms+renesas@verge.net.au>
 <1448263004-14548-2-git-send-email-horms+renesas@verge.net.au>
 <565305BD.5070306@cogentembedded.com>
In-Reply-To: <565305BD.5070306@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 23, 2015 at 03:25:33PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/23/2015 10:16 AM, Simon Horman wrote:
> 
> >0c9400fab882 ("Merge branch 'heads/dt-for-v4.5' into next") introduced
> >pfc pins to the alt device tree but did not reference them. This patch
> 
>    Merge introduced? I thought there was a concrete commit doing that...

Indeed, I will fix that.
