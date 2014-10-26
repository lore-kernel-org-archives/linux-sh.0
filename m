From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 26 Oct 2014 13:04:45 +0000
Subject: Re: [PATCH v4 5/9] ARM: shmobile: marzen: Enable DU device in DT
Message-Id: <544CF16D.7030208@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414152241-5390-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414152241-5390-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 10/26/2014 3:49 PM, Laurent Pinchart wrote:

>>> Specify the DU output topology, enable the DU device and configure the
>>> related pins.

>>> Signed-off-by: Laurent Pinchart
>>> <laurent.pinchart+renesas@ideasonboard.com>
>>> ---

>>>    arch/arm/boot/dts/r8a7779-marzen.dts | 81 ++++++++++++++++++++++++++++++
>>>    1 file changed, 81 insertions(+)

>>> diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts
>>> b/arch/arm/boot/dts/r8a7779-marzen.dts index 9e1b859190ca..64a5d634edc1
>>> 100644
>>> --- a/arch/arm/boot/dts/r8a7779-marzen.dts
>>> +++ b/arch/arm/boot/dts/r8a7779-marzen.dts
>>> @@ -69,6 +69,76 @@
>>>    			gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
>>>    		};
>>>    	};
>>> +
>>> +	vga-encoder {
>>> +		compatible = "adi,adv7123";

>> [...]

>>> +	lvds-enc {

>> Using "lvds-encoder" would have been more consistent.

> I'll fix that.

>>> +		compatible = "thine,thc63lvdm83d";
>>> +
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		ports {
>>> +			port@0 {

>> Hm, I don't see the "reg" prop, where is it?

> In arch/arm/boot/dts/r8a7779.dtsi.

    Hm, you're describing a board specific device, how it would get into the 
SoC specific device tree?

WBR, Sergei

