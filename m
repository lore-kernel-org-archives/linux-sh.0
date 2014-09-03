From: Simon Horman <horms@verge.net.au>
Date: Wed, 03 Sep 2014 00:09:15 +0000
Subject: Re: [PATCH v2 00/10] sh73a0 common clock framework implementation
Message-Id: <20140903000915.GF23704@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 02, 2014 at 11:12:56AM +0200, Ulrich Hecht wrote:
> Hi!
> 
> Here's an updated sh73a0 CCF implementation.  It adds the missing clock
> assignments, CMT1, and various minor fixes.  It also splits off the parent
> selection for the DIV6 clocks so it can be merged without requiring the DIV6
> driver patch.
> 
> CU
> Uli
> 
> 
> Changes since v1:
> - div6 patch replaced with v4
> - split off div6 extended clocks
> - added cmt1 DT description
> - added MSTP clock assignments
> - reordered according to dependencies
> - removed dummy frequencies in extal2, extcki
> - removed enable_on_init on zb1 and flctlck
> - added missing tpu4 in mstp3_clks
> - use c->parent in cpg driver
> - fix some style issues
> 
> 
> Ulrich Hecht (10):
>   clk: shmobile: sh73a0 common clock framework implementation
>   ARM: shmobile: sh73a0: Common clock framework DT description
>   ARM: shmobile: sh73a0: common clock framework board support
>   ARM: shmobile: sh73a0: add MSTP clock assignments to DT
>   ARM: shmobile: sh73a0: Add CMT1 device to DT
>   ARM: shmobile: kzm9g-reference: Enable CMT1 in device tree
>   ARM: shmobile: kzm9g: require ZB1 clock for Ethernet controller
>   clk: shmobile: Add r8a7740, sh73a0 SoCs to MSTP bindings
>   clk: shmobile: div6: support selectable-input clocks
>   ARM: shmobile: sh73a0: add selectable sources to DIV6 clocks

Hi Ulrich,

in general this seems nice to me. I have a few observations:

* It looks like some of the "ARM: shmobile:" patches,
  especially patches 2 - 7, may break bisection. If
  so could you re-arrange the patches to avoid this?

* It looks like you are enabling CMT1. Thanks for that,
  for some reason I thought that I had already handled that: it seems not.

* Would it be useful if I made a series on top of your series
  to enable serial via DT. Again, I thought I had already handled
  that too but it seems I haven't.
