From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 03 Sep 2015 07:04:59 +0000
Subject: Re: [PATCH v8 01/07] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
Message-Id: <2493910.rKP6BgnZy6@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831062918.24004.15458.sendpatchset@little-apple>
In-Reply-To: <20150831062918.24004.15458.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Monday 31 August 2015 15:38:40 Geert Uytterhoeven wrote:
> On Mon, Aug 31, 2015 at 12:44 PM, Laurent Pinchart wrote:
> > On Monday 31 August 2015 15:29:18 Magnus Damm wrote:
> >> --- 0001/arch/arm64/Kconfig.platforms
> >> +++ work/arch/arm64/Kconfig.platforms 2015-08-29 18:20:52.022366518 +0900
> >> @@ -66,6 +66,22 @@ config ARCH_SEATTLE
> >>       help
> >>         This enables support for AMD Seattle SOC Family
> >> 
> >> +config ARCH_SHMOBILE
> >> +     bool
> > 
> > It's tempting to get rid of ARCH_SHMOBILE going forward and define
> > ARCH_RENESAS on ARM32 instead. I'm not sure whether that's worth it, even
> > though the change would just be a search & replace.
> 
> What's the meaning of "ARCH_RENESAS"?
> Does that include H8/300, m32r, and SuperH, too?
> 
> I know "SH Mobile" has been used for both SuperH and ARM32, but it's
> still closer ;-)

Let's postpone that until arch/h8300 and arch/m32r become deprecated then ;-)

It's still a bit annoying not to have a proper name to describe SuperH, ARM32 
and ARM64 SoCs that share the same Renesas IP cores.

-- 
Regards,

Laurent Pinchart

