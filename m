From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 12 May 2014 23:37:41 +0000
Subject: Re: [PATCH] ARM: shmobile: dts: Move interrupt-parent property to root node
Message-Id: <1627187.1ceB3Z4cgL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1398818488-6591-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398818488-6591-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 30 April 2014 10:05:16 Wolfram Sang wrote:
> On Wed, Apr 30, 2014 at 02:41:28AM +0200, Laurent Pinchart wrote:
> > There's no need to duplicate the interrupt-parent property in all DT
> > nodes as the kernel automatically walks parent nodes to find the
> > property. Specify it once in the root node only.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Could you please pick this up for v3.16 ?

-- 
Regards,

Laurent Pinchart

