From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Sep 2013 05:13:25 +0000
Subject: Re: [PATCH v6 2/2] ARM: shmobile: r8a73a4: add a DT node for the DMAC
Message-Id: <20130927051325.GB31063@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1380216603-14645-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1380216603-14645-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 26, 2013 at 07:30:03PM +0200, Guennadi Liakhovetski wrote:
> Add a DT node for the only system DMAC instance on r8a73a4. The RT DMAC
> can be added later under the same multiplexer, because they can serve the
> same slaves and use the same MID-RID values. Configuration data is
> supplied to the driver, using a compatibility match string.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks, queued up for v3.13.
