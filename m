From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Sep 2013 09:05:41 +0000
Subject: Re: [PATCH/RFC v4] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <2096875.5p7e9JmdtM@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

(CC'ing Linus Walleij)

On Wednesday 25 September 2013 14:36:36 Simon Horman wrote:
> On Mon, Sep 23, 2013 at 05:38:47PM +0200, Guennadi Liakhovetski wrote:
> > Add SDHI0, SDHI1 and MMCIF interfaces to armadillo800eva-reference with
> > regulators and pin configurations.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> > 
> > v4:
> > 
> > 1. now that PFC pinctrl is usable with DT, we can use proper regulators
> > and pin configurations on armadillo800eva
> > 
> > 2. corrected SDHI compatibility strings
> > 
> > 3. RFC because I don't know how to enable choosing between CON14 and CON8.
> > In .c version this is done by reading GPIO 6. To do the same in DT mode
> > we'd probably have to use some run-time DT patching, which isn't possible
> > yet, AFAICS.
> 
> I agree with your reasoning there, though perhaps Laurent or Magnus
> have a more enlightened view of things.

I'm tempted to say this should be handled by the boot loader, which should 
then patch the DT accordingly. This is probably just a poor attempt not to 
solve the problem in Linux though :-)

Linus, do you have an opinion on this ? The board has two connectors (MMC/SD 1 
and wifi module) that are not usable concurrently. The user can select which 
connector to use through a hardware switch that existing board code reads at 
init time to determine which platform devices to register and how to configure 
pin muxing. Are you aware of a similar problem on other boards that would have 
been solved already ?

> To my way of thinking it would be good to merge this change as is,
> which an appropriate disclaimer about functionality in the changelog
> above the scissors. But I do not feel strongly about this and I
> am happy to wait for fuller functionality.

-- 
Regards,

Laurent Pinchart

