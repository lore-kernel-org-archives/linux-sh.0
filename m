From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Mar 2013 10:35:28 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: sh73a0: move SDHI and MMCIF DT nodes to sh73a0.dtsi
Message-Id: <20130321103528.GD2348@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1303191341140.11768@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303191341140.11768@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 19, 2013 at 01:47:43PM +0100, Guennadi Liakhovetski wrote:
> To avoid having to repeat common DT node properties in all .dts files
> move them to SoC's .dtsi file, setting their status to "disabled."
> Individual boards will pick up devices, that they want to use and
> change their DT node status to enabled.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, applied to the boards branch.
