From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 19 Mar 2014 10:07:52 +0000
Subject: Re: [PATCH/RFC 0/5] Fix the sh_eth race between open and MDIO bus registration
Message-Id: <1945175.fXzpfL9ArV@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1395185156-6681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395185156-6681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Wednesday 19 March 2014 10:14:53 Ben Dooks wrote:
> On 19/03/14 08:41, Geert Uytterhoeven wrote:
> > On Wed, Mar 19, 2014 at 12:25 AM, Laurent Pinchart wrote:
> >>
> >> Laurent Pinchart (5):
> >>    sh_eth: Use the platform device for memory allocation
> >>    sh_eth: Use the platform device as the MDIO bus parent
> >>    sh_eth: Simplify MDIO bus initialization and release
> >>    sh_eth: Register MDIO bus before registering the network device
> >>    sh_eth: Remove goto statements that jump straight to a return
> > 
> > Thanks, the changes look fine to me, so
> 
> I think the only issue I have is the re-parent of the MDIO device. 
> 
> My view also is that the probe should explicitly get a reference if it is
> going to be created sub-devices.

I'm not sure to follow you, could you please elaborate on that ? What should 
take a reference on what ?

-- 
Regards,

Laurent Pinchart

