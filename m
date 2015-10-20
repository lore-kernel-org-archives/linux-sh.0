From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 20 Oct 2015 16:01:03 +0000
Subject: Re: [PATCH v4 1/5] [RFC] clk: shmobile: Add new Renesas CPG/MSSR DT bindings
Message-Id: <CANqRtoS6QpWJY99aD8KyGHgySxqzzBPic-k_a-VcZE6LVFFRow@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
	<1444999760-15750-2-git-send-email-geert+renesas@glider.be>
	<CAMuHMdVhBipbf13o0jb3H6qmcewh6CCtq3=Hj-9nvgar+AYdFg@mail.gmail.com>
In-Reply-To: <CAMuHMdVhBipbf13o0jb3H6qmcewh6CCtq3=Hj-9nvgar+AYdFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geert,

On Tue, Oct 20, 2015 at 9:16 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Oct 16, 2015 at 2:49 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
>> @@ -0,0 +1,71 @@
>> +* Renesas Clock Pulse Generator / Module Standby and Software Reset
>> +
>> +On Renesas ARM SoCs (SH/R-Mobile, R-Car, RZ), the CPG (Clock Pulse Generator)
>> +and MSSR (Module Standby and Software Reset) blocks are intimately connected,
>> +and share the same register block.
>> +
>> +They provide the following functionalities:
>> +  - The CPG block generates various core clocks,
>> +  - The MSSR block provides two functions:
>> +      1. Module Standby, providing a Clock Domain to control the clock supply
>> +        to individual SoC devices,
>> +      2. Reset Control, to perform a software reset of individual SoC devices.
>> +
>> +Required Properties:
>> +  - compatible: Must be one of:
>> +      - "renesas,r8a7791-cpg-mssr" for the r8a7791 SoC
>
> I'll drop the reference to "r8a7791", as we won't convert r8a7791 (yet).
>
>> +      - "renesas,r8a7795-cpg-mssr" for the r8a7795 SoC
>> +
>> +  - reg: Base address and length of the memory resource used by the CPG/MSSR
>> +    block
>> +
>> +  - clocks: References to external parent clocks, one entry for each entry in
>> +    clock-names
>> +  - clock-names: List of external parent clock names. Valid names are:
>> +      - "extal" (r8a7791, r8a7795)
>> +      - "extalr" (r8a7795)
>> +      - "usb_extal" (r8a7791)
>
> Likewise.

Yeah, dropping r8a7791 from the initial version of this DT binding
seems like a good idea to me as well.

All looks good to me. Thanks for preparing this nicely written DT
binding document!

Reviewed-by: Magnus Damm <damm+renesas@opensource.se>

Cheers,

/ magnus
