From: Rob Herring <robh@kernel.org>
Date: Mon, 11 Jan 2016 02:56:37 +0000
Subject: Re: [PATCH v2] rcar_jpu: Add R-Car Gen2 Fallback Compatibility String
Message-Id: <20160111025637.GA17825@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1452478400-4267-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1452478400-4267-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Mon, Jan 11, 2016 at 11:13:20AM +0900, Simon Horman wrote:
> Add fallback compatibility string.
> This is in keeping with the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> v2
> * Make fallback compat string for R-Car Gen2 rather than all renesas
>   hardware: that seems too generic
> ---
>  Documentation/devicetree/bindings/media/renesas,jpu.txt | 13 +++++++------
>  drivers/media/platform/rcar_jpu.c                       |  1 +
>  2 files changed, 8 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
