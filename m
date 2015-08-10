From: Simon Horman <horms@verge.net.au>
Date: Mon, 10 Aug 2015 23:22:49 +0000
Subject: Re: [PATCH 0/2] kill bockw reference platform
Message-Id: <20150810232249.GB9484@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1438965297-12888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1438965297-12888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 07, 2015 at 06:34:55PM +0200, Ulrich Hecht wrote:
> Hi!
> 
> As discussed off-list, here's the burial of the r8a7778 bockw reference
> platform, the penultimate step in removing legacy platforms for good.

Thanks! I have queued these up for v4.4.

As per Geert's feedback, please send a follow-up patch to remove the
comment about reference at the bottom of
Documentation/devicetree/bindings/arm/shmobile.txt.
