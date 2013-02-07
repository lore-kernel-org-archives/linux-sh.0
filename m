From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 07 Feb 2013 16:08:41 +0000
Subject: Re: [PATCH 2/3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <3620099.Y0WWESBTg5@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130207073203.GB3825@verge.net.au> <87k3qkzg5p.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3qkzg5p.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, magnus.damm@gmail.com

On Thursday 07 February 2013 00:23:18 Kuninori Morimoto wrote:
> > I'm not sure of a good solution, however selecting OF where USE_OF wasn't
> > previously selected seems to cause problems on at least ARM because
> > devtree.c is then compiled without OF_FLATTREE selected.

Isn't that an ARM issue ? If OF && !OF_FLATTREE is a valid kernel 
configuration devtree.c should compile.

> > That results in the following awesomeness as pointed out to me by
> > Morimoto-san.

I've run into that before as well. I'll remove the dependency on OF for now as 
it's not strictly required.

> > arch/arm/kernel/devtree.c: In function 'arm_dt_memblock_reserve':
> > arch/arm/kernel/devtree.c:43:7: error: 'initial_boot_params' undeclared
> > (first use in this function) arch/arm/kernel/devtree.c:43:7: note: each
> > undeclared identifier is reported only once for each function it appears
> > in arch/arm/kernel/devtree.c: In function 'setup_machine_fdt':
> > arch/arm/kernel/devtree.c:193:2: error: 'initial_boot_params' undeclared
> > (first use in this function) arch/arm/kernel/devtree.c:194:2: error:
> > implicit declaration of function 'of_get_flat_dt_root'
> > arch/arm/kernel/devtree.c:196:3: error: implicit declaration of function
> > 'of_flat_dt_match' arch/arm/kernel/devtree.c:209:3: error: implicit
> > declaration of function 'of_get_flat_dt_prop'
> > arch/arm/kernel/devtree.c:209:8: warning: assignment makes pointer from
> > integer without a cast arch/arm/kernel/devtree.c:220:8: warning:
> > assignment makes pointer from integer without a cast
> > arch/arm/kernel/devtree.c:222:9: warning: assignment makes pointer from
> > integer without a cast arch/arm/kernel/devtree.c:228:2: error: implicit
> > declaration of function 'of_scan_flat_dt'
> > arch/arm/kernel/devtree.c:228:18: error: 'early_init_dt_scan_chosen'
> > undeclared (first use in this function) arch/arm/kernel/devtree.c:230:18:
> > error: 'early_init_dt_scan_root' undeclared (first use in this function)
> > arch/arm/kernel/devtree.c:232:18: error: 'early_init_dt_scan_memory'
> > undeclared (first use in this function) make[1]: ***
> > [arch/arm/kernel/devtree.o] Error 1
> 
> OF_FLATTREE
> OF_EARLY_FLATTREE
> 
> both are required ?

-- 
Regards,

Laurent Pinchart

