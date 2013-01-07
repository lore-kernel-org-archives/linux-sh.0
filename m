From: Simon Horman <horms@verge.net.au>
Date: Mon, 07 Jan 2013 02:31:01 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: add function declarations for sh7372 DT helper functions
Message-Id: <20130107023101.GM2935@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1212311213510.24596@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1212311213510.24596@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Dec 31, 2012 at 12:23:50PM +0100, Guennadi Liakhovetski wrote:
> sh7372_add_early_devices_dt() and sh7372_add_standard_devices_dt() are
> defined as global functions in arch/arm/mach-shmobile/setup-sh7372.c,
> but their declarations are missing. Add them to common.h, where similar
> functions for this and other SoC types are already declared.

Thanks, applied to the soc branch.
