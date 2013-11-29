From: Tejun Heo <tj@kernel.org>
Date: Fri, 29 Nov 2013 20:42:31 +0000
Subject: Re: [PATCH V3 1/2] sata_rcar: Add R-Car Gen2 SATA PHY support
Message-Id: <20131129204231.GE21755@mtj.dyndns.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1383912570-8393-1-git-send-email-valentine.barshak@cogentembedded.com>
 <1383912570-8393-2-git-send-email-valentine.barshak@cogentembedded.com>
 <52951B4D.3030205@cogentembedded.com>
 <20131129201406.GD21755@mtj.dyndns.org>
 <5298FAA8.2050300@cogentembedded.com>
In-Reply-To: <5298FAA8.2050300@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valentine <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>

On Sat, Nov 30, 2013 at 12:35:52AM +0400, Valentine wrote:
> On 11/30/2013 12:14 AM, Tejun Heo wrote:
> >Hello,
> >
> >On Wed, Nov 27, 2013 at 02:06:05AM +0400, Valentine wrote:
> >>On 11/08/2013 04:09 PM, Valentine Barshak wrote:
> >>
> >>Tejun,
> >>are you OK with taking this?
> >
> >Yeah, the stat part looks okay to me.  How the two should be routed?
> >Both through libata or should I just take the first one?
> 
> I'm not sure about that. I'm more concerned about the first one.
> But I wouldn't mind if you take both.

Applied the first one to libata/for-3.14.  Are people happy with the
second one?  If so, I'll put route that through libata/for-3.14 too.

Thanks.

-- 
tejun
