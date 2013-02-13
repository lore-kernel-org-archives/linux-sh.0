From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 04:31:00 +0000
Subject: Re: [PATCH/RFC 1/3] pinctrl: sh-pfc: support sparse GPIO numbers
Message-Id: <20130213043100.GL30425@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360684204-12888-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360684204-12888-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 12, 2013 at 04:50:02PM +0100, Guennadi Liakhovetski wrote:
> Not on all sh-/r-mobile platfotms all pins are numbered contiguously from 0
> to N-1. On all ARM-based platforms datasheets use simple numbers to identify
> them, unlike some SuperH-based SoC, naming pins, using strings, e.g. A31:A0,
> B11:B0, C31:C0, etc. So far the sg-pfc pinctrl driver supported only
> contiguous pin numbering. This patch adds support for sparse pin numbers to
> support sh73a0 and any other similar SoCs.

Applied to a new topic branch, topic/pinmux-sparse.
