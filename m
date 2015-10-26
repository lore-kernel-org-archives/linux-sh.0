From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Oct 2015 19:02:45 +0000
Subject: Re: [PATCH v4 1/5] [RFC] clk: shmobile: Add new Renesas CPG/MSSR DT bindings
Message-Id: <CAMuHMdVtiEokxPwTsBXhaxwHszm+Wy5CDfNzpyzAxAdWU_fdUA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
	<1444999760-15750-2-git-send-email-geert+renesas@glider.be>
	<2183540.y4vKjWID3s@avalon>
In-Reply-To: <2183540.y4vKjWID3s@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Laurent,

On Fri, Oct 23, 2015 at 1:10 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 16 October 2015 14:49:16 Geert Uytterhoeven wrote:
>> On Renesas ARM SoCs (SH/R-Mobile, R-Car, RZ), the CPG (Clock Pulse
>> Generator) and MSSR (Module Standby and Software Reset) blocks are
>> intimately connected, and share the same register block.
>>
>> Hence it makes sense to describe these two blocks using a
>> single device node in DT, instead of using a hierarchical structure with
>> multiple nodes, using a mix of generic and SoC-specific bindings.
>>
>> These new DT bindings are intended to replace the existing DT bindings
>> for CPG core clocks ("renesas,*-cpg-clocks", "renesas,cpg-div6-clock")
>> and module clocks ("renesas,*-mstp-clocks"), at least for new SoCs.
>>
>> This will make it easier to add module reset support later, which is
>> currently not implemented, and difficult to achieve using the existing
>> bindings due to the intertwined register layout.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
>> @@ -0,0 +1,71 @@
>> +* Renesas Clock Pulse Generator / Module Standby and Software Reset
>> +
>> +On Renesas ARM SoCs (SH/R-Mobile, R-Car, RZ), the CPG (Clock Pulse
>> Generator)
>> +and MSSR (Module Standby and Software Reset) blocks are intimately
>> connected,
>> +and share the same register block.
>> +
>> +They provide the following functionalities:
>> +  - The CPG block generates various core clocks,
>> +  - The MSSR block provides two functions:
>> +      1. Module Standby, providing a Clock Domain to control the clock
>> supply
>> +      to individual SoC devices,
>> +      2. Reset Control, to perform a software reset of individual SoC
>> devices.

[...]

>> +  - #power-domain-cells: Must be 0
>> +      - SoC devices that are part of the CPG/MSSR Clock Domain and can be
>> +     power-managed through Module Standby should refer to the CPG device
>> +     node in their "power-domains" property, as documented by the generic PM
>> +     Domain bindings in
>> +     Documentation/devicetree/bindings/power/power_domain.txt.
>> +
>> +
>> +Examples
>> +--------
>> +
>> +  - CPG device node:
>> +
>> +     cpg: clock-controller@e6150000 {
>> +             compatible = "renesas,r8a7795-cpg-mssr";
>> +             reg = <0 0xe6150000 0 0x1000>;
>> +             clocks = <&extal_clk>, <&extalr_clk>;
>> +             clock-names = "extal", "extalr";
>> +             #clock-cells = <2>;
>> +             #power-domain-cells = <0>;
>> +     };
>> +
>> +
>> +  - CPG/MSSR Clock Domain member device node:
>
> Would it make sense to show two examples, one for a device whose driver
> manages the MSTP clock manually, and another one for a device whose driver
> delegates that to the power domain ?
>
> I hate using the word driver in DT bindings, but unfortunately that's
> essentially what it boils down to here as the decision to specify the power
> domain is really based on the driver, not on the hardware.

IMHO it's not the driver, but the on-SoC module and its representation in DT.
Cfr. commit 797a0626e08ca4af ("ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock
Domain", which states:

|   Add "power-domains" properties to all device nodes for devices that are
|   part of the CPG/MSTP Clock Domain and can be power-managed through an
|   MSTP clock.  This applies to most on-SoC devices, which have a
|   one-to-one mapping from SoC device to DT device node.  Notable
|   exceptions are the "display" and "sound" nodes, which represent multiple
|   SoC devices, each having their own MSTP clocks.

If a single device block (sharing the same register space), represented in
DT as a single device node, actually represents multiple modules, there's no
one-to-one mapping from SoC device to DT device node.
Hence the device node will have multiple module clocks, and the driver will
have to take care of managing them explicitly.

The register space sharing is an SoC-specific issue.
The single device node is a DT binding issue.

Perhaps such devices should use subnodes, so each of them can represent a
module, each with its own module clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
