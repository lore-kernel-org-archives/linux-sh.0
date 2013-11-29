From: Tejun Heo <tj@kernel.org>
Date: Fri, 29 Nov 2013 20:14:06 +0000
Subject: Re: [PATCH V3 1/2] sata_rcar: Add R-Car Gen2 SATA PHY support
Message-Id: <20131129201406.GD21755@mtj.dyndns.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1383912570-8393-1-git-send-email-valentine.barshak@cogentembedded.com>
 <1383912570-8393-2-git-send-email-valentine.barshak@cogentembedded.com>
 <52951B4D.3030205@cogentembedded.com>
In-Reply-To: <52951B4D.3030205@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valentine <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>

Hello,

On Wed, Nov 27, 2013 at 02:06:05AM +0400, Valentine wrote:
> On 11/08/2013 04:09 PM, Valentine Barshak wrote:
> 
> Tejun,
> are you OK with taking this?

Yeah, the stat part looks okay to me.  How the two should be routed?
Both through libata or should I just take the first one?

Thanks.

-- 
tejun
