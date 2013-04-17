From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 17 Apr 2013 08:49:02 +0000
Subject: Re: [PATCH v2 resend] sh-pfc: r8a7779: add VIN pin groups
Message-Id: <2784841.VJ7X2v71QQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201304170217.29026.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304170217.29026.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Thank you for the patch.

On Wednesday 17 April 2013 02:17:28 Sergei Shtylyov wrote:
> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Add VIN DATA[0:7]/CLK/HSYNC/VSYNC pin groups to R8A7779 PFC driver.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> These pins will be needed by the upcoming R-Car VIN driver...
> The patch is atop of Simon's 'renesas.git' tree, 'renesas-next-20130416'
> tag.
> 
> Changes from the original posting:
> - replaced hardcoded pin numbers with RCAR_GP_PIN() macro invocations;
> - clarified the changelog;
> - lowercased the SoC name in the subject.
> 
> Resending as I forgot to actually lowercase the SoC name. :-)
> 
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c |  147 ++++++++++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 1 deletion(-)

-- 
Regards,

Laurent Pinchart

