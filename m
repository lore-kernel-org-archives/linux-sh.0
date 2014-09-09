From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 09 Sep 2014 21:26:50 +0000
Subject: Re: [PATCH v2 02/10] ARM: shmobile: sh73a0: Common clock framework DT description
Message-Id: <235053211.N3Dbb6z3QE@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday 04 September 2014 16:14:42 Simon Horman wrote:
> On Tue, Sep 02, 2014 at 11:12:58AM +0200, Ulrich Hecht wrote:
> > Declares all sh73a0 clocks supported by the legacy clock framework as well
> > as the KZM9G-specific overrides.
> > 
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > ---
> > 
> >  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   4 +
> >  arch/arm/boot/dts/sh73a0.dtsi                | 346 ++++++++++++++++++++++
> >  include/dt-bindings/clock/sh73a0-clock.h     |  79 ++++++
> 
> Please split this into three patches, one per file.

include/dt-bindings/clock/sh73a0-clock.h can be moved to the first patch.

-- 
Regards,

Laurent Pinchart

