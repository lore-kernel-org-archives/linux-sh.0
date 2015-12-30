From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 30 Dec 2015 22:06:57 +0000
Subject: Re: [PATCH v5 03/14] ARM: shmobile: r8a7791: Add DU node to device tree
Message-Id: <56845581.3010605@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414332679-15497-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414332679-15497-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 12/27/2015 03:07 AM, Laurent Pinchart wrote:

>>> Add the DU device with a disabled state. Boards that want to enable the
>>> DU need to specify the output topology
>>>
>>> Signed-off-by: Laurent Pinchart
>>> <laurent.pinchart+renesas@ideasonboard.com>
>>> ---
>>>
>>>    arch/arm/boot/dts/r8a7791.dtsi | 30 ++++++++++++++++++++++++++++++
>>>    1 file changed, 30 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/r8a7791.dtsi
>>> b/arch/arm/boot/dts/r8a7791.dtsi index 74f18d89a35f..6b06a7665fae 100644
>>> --- a/arch/arm/boot/dts/r8a7791.dtsi
>>> +++ b/arch/arm/boot/dts/r8a7791.dtsi
>>> @@ -695,6 +695,36 @@
>>>    		renesas,#wpf = <4>;
>>>    	};
>>>
>>> +	du: display@feb00000 {
>>> +		compatible = "renesas,du-r8a7791";
>>> +		reg = <0 0xfeb00000 0 0x40000>,
>>> +		      <0 0xfeb90000 0 0x1c>;
>>> +		reg-names = "du", "lvds.0";
>>> +		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
>>> +			     <0 268 IRQ_TYPE_LEVEL_HIGH>;
>>> +		clocks = <&mstp7_clks R8A7791_CLK_DU0>,
>>> +			 <&mstp7_clks R8A7791_CLK_DU1>,
>>> +			 <&mstp7_clks R8A7791_CLK_LVDS0>;
>>> +		clock-names = "du.0", "du.1", "lvds.0";
>>> +		status = "disabled";
>>> +
>>> +		ports {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +
>>> +			port@0 {
>>> +				reg = <0>;
>>> +				du_out_rgb: endpoint {
>>> +				};
>>> +			};
>>> +			port@1 {
>>> +				reg = <1>;
>>> +				du_out_lvds0: endpoint {
>>> +				};
>>
>> Hm, my manual tell me LVDS is supported on DU0 only for R8A7791/3...
>
> Yes, but note that the port number doesn't correspond to the DU number. A
> given port can be driven by multiple DU channels on some of the R-Car SoCs.

    Ah, I didn't dive into these matters deep enough...

> The routing tables are defined in the per-SoC device info in
> drivers/gpu/drm/rcar-du/rcar_du_drv.c.

    Thank you for the pointer!
    I've fixed up the Porter patch to hang HDMI deconder from the "correct" 
port 0 ISO port 1 and I lost the picture on my LVDS display after doing that. 
With the wrong Porter patch, both displays work...

MBR, Sergei

