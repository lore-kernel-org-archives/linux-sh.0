From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Sep 2013 05:13:16 +0000
Subject: Re: [PATCH v6 1/2] ARM: shmobile: r8a73a4: add a clock alias for the DMAC in DT mode
Message-Id: <20130927051316.GA31063@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1380216603-14645-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1380216603-14645-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 26, 2013 at 07:30:02PM +0200, Guennadi Liakhovetski wrote:
> Devices, initialised from the Device Tree and from platform code usually
> have different names. This patch adds a clock alias for DMAC on r8a73a4
> in DT mode.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks, queued up for v3.13.
