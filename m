From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 28 Aug 2015 16:50:00 +0000
Subject: Re: [PATCH/RFC 07/10] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <55E09138.7090706@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-8-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-8-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 08/28/2015 08:30 AM, Simon Horman wrote:

>>>>> +       phy0: ethernet-phy@0 {
>>>>> +               rxc-skew-ps = <900>;
>>>>> +               rxdv-skew-ps = <0>;
>>>>> +               rxd0-skew-ps = <0>;
>>>>> +               rxd1-skew-ps = <0>;
>>>>> +               rxd2-skew-ps = <0>;
>>>>> +               rxd3-skew-ps = <0>;
>>>>> +               txc-skew-ps = <900>;
>>>>> +               txen-skew-ps = <0>;
>>>>> +               txd0-skew-ps = <0>;
>>>>> +               txd1-skew-ps = <0>;
>>>>> +               txd2-skew-ps = <0>;
>>>>> +               txd3-skew-ps = <0>;
>>>>
>>>>
>>>>     Hm, and the PHY driver can parse all this?
>>
>>> Please see drivers/net/phy/micrel.c:ksz9021_config_init().
>>
>>     OK, but don't we need to specify some kind of "compatible" prop?
>
> Not according to my reading of
> Documentation/devicetree/bindings/net/micrel-ksz90x1.txt

    Hm... I wonder why these props have generic names if the registers 
programmed with their values are clearly vendor-unique... These bindings don't 
look good to me... :-/

MBR, Sergei

