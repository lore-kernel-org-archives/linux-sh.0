From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Jun 2013 07:18:25 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: sh73a0: remove "0x" prefix from DT node names
Message-Id: <20130618071824.GE24960@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533092-23555-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1370533092-23555-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 06, 2013 at 05:38:12PM +0200, Guennadi Liakhovetski wrote:
> The convention for Device Tree node names is <device>@<hex-address>, where
> the part after '@' shouldn't contain the "0x" prefix. Fix the sh73a0.dtsi
> DT names.

Thanks, I have queued this up in the dt branch.
