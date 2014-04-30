From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 30 Apr 2014 21:23:11 +0000
Subject: Re: [PATCH/RFC 3/4] of/clk: Register clocks suitable for Runtime PM with the PM core
Message-Id: <2068296.FXWLXn1mqR@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
 <1398334403-26181-4-git-send-email-geert+renesas@glider.be>
 <CAPDyKFr02yyhGNncYX2AgBXTA3Sc0AGQcExjtLvQ5QU0_=YJwg@mail.gmail.com>
In-Reply-To: <CAPDyKFr02yyhGNncYX2AgBXTA3Sc0AGQcExjtLvQ5QU0_=YJwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Ulf and Geert,

On Thursday 24 April 2014 15:11:24 Ulf Hansson wrote:
> On 24 April 2014 12:13, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > When adding a device from DT, check if its clocks are suitable for Runtime
> > PM, and register them with the PM core.
> > If Runtime PM is disabled, just enable the clock.
> > 
> > This allows the PM core to automatically manage gate clocks of devices for
> > Runtime PM.
> 
> Normally I don't think it's a good idea to "automatically" manage
> clocks from PM core or any other place but from the driver (and
> possibly the subsystem).
> 
> The reason is simply that we hide things that normally is supposed to
> be handled by the driver. Typically a cross SOC driver should work
> fine both with and without a pm_domain. It should also not rely on
> CONFIG_PM_RUNTIME.

That's a very good point. Geert, what do you think should happen if 
CONFIG_PM_RUNTIME is not set ? I don't have a strong opinion (yet) on whether 
we could require CONFIG_PM_RUNTIME, but it would indeed be nice to support 
both cases. One option would be to keep the clocks enabled unconditionally in 
that case, as not setting CONFIG_PM_RUNTIME means that the user doesn't care 
(or cares less) about power consumption.

> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

-- 
Regards,

Laurent Pinchart

