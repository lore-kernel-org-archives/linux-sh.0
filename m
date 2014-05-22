From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 May 2014 22:42:56 +0000
Subject: Re: [PATCH v3] clk: shmobile: Add R8A7740-specific clock support
Message-Id: <93388596.mpU9e50d0D@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1400682086-5705-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1768296.AYVfH6xHtk@avalon>
 <CAMuHMdUNpgn1ciHsvqWtEyn0RugxQTaCV+ki=S=5hUbmCjA6tg@mail.gmail.com>
In-Reply-To: <CAMuHMdUNpgn1ciHsvqWtEyn0RugxQTaCV+ki=S=5hUbmCjA6tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Geert,

On Wednesday 21 May 2014 17:50:35 Geert Uytterhoeven wrote:
> On Wed, May 21, 2014 at 5:41 PM, Laurent Pinchart wrote:
> >> +cpg_clocks: cpg_clocks@e6150000 {
> >> +        compatible = "renesas,r8a7740-cpg-clocks";
> >> +        reg = <0xe6150000 0x10000>;
> > 
> > This range covers the MSTP registers. Unlike other Renesas SoCs with CCF
> > support in mainline, the MSTP registers are in the middle of the CPG
> > address space here, which is quite problematic.
> 
> This is also the case for R-Car Gen2?!?
> 
>                 /* Special CPG clocks */
>                 cpg_clocks: cpg_clocks@e6150000 {
>                         compatible = "renesas,r8a7791-cpg-clocks",
>                                      "renesas,rcar-gen2-cpg-clocks";
>                         reg = <0 0xe6150000 0 0x1000>;
> 
>                 mstp0_clks: mstp0_clks@e6150130 {
>                         compatible = "renesas,r8a7791-mstp-clocks",
> "renesas,cpg-mstp-clocks";
>                         reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;

Indeed :-/ It looks like we're just lucky that of_iomap() doesn't request the 
memory resource.

Do you think it would make sense to move the MSTP nodes inside the CPG node to 
better describe the hardware, and avoid future breakages if of_iomap() starts 
calling request_resource() tomorrow ?

> Or perhaps I am misunderstanding what you mean?

-- 
Regards,

Laurent Pinchart

