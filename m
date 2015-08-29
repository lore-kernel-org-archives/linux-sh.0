From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 29 Aug 2015 14:32:10 +0000
Subject: Re: [PATCH 0/6] arm64: renesas: r8a7795/salvator-x Serial Support
Message-Id: <CANqRtoQqBm7FAZQdpXyACUVh5kSSUJ7dvdEqejNgauDdiuck2A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440612832-17627-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440612832-17627-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thu, Aug 27, 2015 at 3:13 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>         Hi,
>
> This patch series enhances serial port support on r8a7795/Salvator-X:
>   - Add dummy dma-controller nodes, so we can start describing DMA
>     channels for DMA slaves now, leading to less patch conflicts later,
>   - Add all (H)SCIF device nodes (incl. clocks, clock domain, and DMA
>     properties),
>   - Enable SCIF1 on serial1,
>   - Proof-of-concept of using HSCIF1 on serial1 use a DT overlay.
>
> This series depends on "[PATCH 0/3] arm64: renesas: r8a7795 clock
> updates".
>
> Unlike SCIF1 (on serial1) and SCIF2 (on serial0), HSCIF1 on serial1
> doesn't use the default pinctrl config, hence it's functionality depends
> on enabling CONFIG_PINCTRL and "[PATCH 0/5] pinctrl: sh-pfc: r8a7795:
> (H)SCIF Updates".
>
> SCIF1 and HSCIF1 were tested on r8a7795/salvator-x.
>
> Geert Uytterhoeven (6):
>   arm64: renesas: r8a7795 dtsi: Mark scif2 disabled
>   arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
>   arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
>   arm64: renesas: r8a7795 dtsi: Add all HSCIF nodes
>   arm64: renesas: salvator-x: Enable SCIF1 on serial1
>   [POC] arm64: renesas: salvator-x dts: Add overlay for HSCIF1

Thanks for cooking up these patches!

FYI, I'm currently in the process of picking out the SCIF related bits
for inclusion in an upcoming minimalistic-and-stable R-Car Gen3 v8
integration series that I intend to post this weekend or early next
week. So please do not update anything.

That said, while going through your patches I noticed that SCIF2 did
not have any dma nodes. I assumed that was something that fell between
the hunks so to say. If that was intentional then please let me know.
In my not-yet-posted series I've fixed that up and all seems fine.

Cheers,

/ magnus
