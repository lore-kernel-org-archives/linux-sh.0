From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Mar 2013 10:46:30 +0000
Subject: Re: [PATCH 1/3 v3] ARM: shmobile: add R8A7778 basis support
Message-Id: <20130327104629.GD413@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87hakhrpmn.wl%kuninori.morimoto.gx@renesas.com>
 <878v5hf4zr.wl%kuninori.morimoto.gx@renesas.com>
 <877gl1f4w4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877gl1f4w4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Mar 21, 2013 at 03:01:36AM -0700, Kuninori Morimoto wrote:
> Add initial support for the R8A7778 R-Car M1A SoC.
> No static virtual mappings are used, all the components
> make use of ioremap().
> DT_MACHINE_START is still wrapped
> in CONFIG_USE_OF to match other mach-shmobile code.
> 
> It is based on v1.0 datasheet
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued up for v3.10 in the soc branch.
