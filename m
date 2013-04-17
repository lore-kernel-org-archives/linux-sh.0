From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Apr 2013 00:36:57 +0000
Subject: Re: [PATCH v2 1/2] ARM: sh-mobile: r8a7740: Make private clock arrays static
Message-Id: <20130417003657.GB16092@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366125380-14528-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366125380-14528-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 16, 2013 at 05:16:19PM +0200, Laurent Pinchart wrote:
> Both clock-r8a7740.c and clock-r8a7790.c define a div4_clks array as
> non-static. Compiling support for both SoCs thus result in a symbol
> redefinition. Fix it by defining the arrays as static.
> 
> To avoid further similar issues, also define the main_clks as static.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, queued-up for v3.11 in the soc-r8a7740 branch.
