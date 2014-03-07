From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 07 Mar 2014 15:45:58 +0000
Subject: Re: [PATCH 1/5] r8a7790.dtsi: add vin[0-3] nodes
Message-Id: <5319F7AA.7040305@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394197299-17528-1-git-send-email-ben.dooks@codethink.co.uk> <1394197299-17528-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394197299-17528-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Mauro Carvalho Chehab <m.chehab@samsung.com>, linux-kernel@vger.kernel.org, magnus.damm@opensource.se, linux-sh@vger.kernel.org, linux-kernel@lists.codethink.co.uk

Hello.

On 03/07/2014 04:01 PM, Ben Dooks wrote:

> Add nodes for the four video input channels on the R8A7790.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

    This patch should have been preceded by the VIN driver patch and bindings 
description, don't you think?

> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index a1e7c39..4c3eafb 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -395,6 +395,38 @@
>   		status = "disabled";
>   	};
>
> +	vin0: vin@0xe6ef0000 {

    ePAPR standard [1] tells us that:

The name of a node should be somewhat generic, reflecting the function of the 
device and not its precise programming model.

    So, I would suggest something like "video". And remove "0x" from the 
address part of the node name please.

WBR, Sergei

