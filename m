From: Simon Horman <horms@verge.net.au>
Date: Thu, 01 Aug 2013 07:42:06 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: ape6evm: add "__initconst" annotations where needed
Message-Id: <20130801074205.GC15265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 31, 2013 at 02:40:14PM +0200, Guennadi Liakhovetski wrote:
> This patch adds __initconst markers to the platform data and resources,
> used on ape6evm as parameters to platform_device_register_resndata().
> The data is duplicated inside that function, therefore original data
> can be discarded after initialisation is completed.
> 
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks, I have queued this up for v3.12 in the cleanup4 branch.
