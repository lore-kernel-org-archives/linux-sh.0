From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 03 Sep 2013 12:11:17 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: r8a7778: add Ether DT support
Message-Id: <2922765.My7X58lhxd@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Paweł,

On Monday 02 September 2013 16:32:34 Pawel Moll wrote:
> On Mon, 2013-09-02 at 15:18 +0100, Laurent Pinchart wrote:
> > Documentation/devicetree/booting-without-of.txt mentions it, as well as a
> > couple of other DT bindings document, but there's no clear documentation
> > of what device_type should be for network device, and whether the property
> > is mandatory or optional. Clarifying the documentation would be great.
> 
> It's documented in the ePAPR spec:
> 
> "The device_type property was used in IEEE 1275 to describe the device’s
> FCode programming model. Because ePAPR does not have FCode, new use of
> the property is deprecated, and it should be included only on cpu and
> memory nodes for compatibility with IEEE 1275–derived device trees."

Thank you for the clarification.

> The bottom line is - don't use it, unless you've good good reasons?

I'll let Sergei share his opinion on whether we've got good reasons :-)

-- 
Regards,

Laurent Pinchart

