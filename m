From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 22 Apr 2013 09:45:31 +0000
Subject: Re: [PATCH v2 2/5] sh-pfc: r8a7778: add VIN pin groups
Message-Id: <1387005.gplDWceT9R@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201304212240.51203.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304212240.51203.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Thanks for the patch.

On Sunday 21 April 2013 22:40:50 Sergei Shtylyov wrote:
> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Add VIN DATA[0:8]/CLK/HSYNC/VSYNC pin groups to R8A7778 PFC driver.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: updated the copyrights.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   74 +++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

