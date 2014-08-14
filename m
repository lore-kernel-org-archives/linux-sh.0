From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Aug 2014 05:32:31 +0000
Subject: Re: [PATCH v5 0/2] Add VIN and ADV7180 device tree support for R8A7790/Lager board
Message-Id: <20140814053231.GA26709@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1793694.Z8xUpkGDQx@wasted.cogentembedded.com>
In-Reply-To: <1793694.Z8xUpkGDQx@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 12:10:19AM +0400, sergei.shtylyov@cogentembedded.com wrote:
> Hello.
> 
>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-v3.16-20140811' tag. Here Ben Dooks adds the VIN and ADV7180
> video decoder device tree support on the R8A7790/Lager board. The patchset
> requires Ben Dooks' 'rcar_vin' and 'soc_camera' DT support patches (already
> merged to the 'media_tree.git' repo) in order to work.
> 
> [1/2] ARM: shmobile: r8a7790: add VIN device nodes
> [2/2] ARM: shmobile: lager: add VIN1/ADV7180 device nodes

Thanks, I have queued these up for v3.18.
