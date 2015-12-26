From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 26 Dec 2015 10:53:36 +0000
Subject: Re: [PATCH v5 09/14] ARM: shmobile: koelsch: Enable DU device in DT
Message-Id: <1921891.dabbkcGt9n@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414332679-15497-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414332679-15497-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Saturday 26 December 2015 02:45:55 Sergei Shtylyov wrote:
> On 12/24/2015 10:54 PM, Sergei Shtylyov wrote:
> >> Specify the DU output topology, enable the DU device and configure the
> >> related pins.
> >> 
> >> Signed-off-by: Laurent Pinchart
> >> <laurent.pinchart+renesas@ideasonboard.com>
> >> ---
> >> 
> >>   arch/arm/boot/dts/r8a7791-koelsch.dts | 16 +++++++++++++---
> >>   1 file changed, 13 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts
> >> b/arch/arm/boot/dts/r8a7791-koelsch.dts
> >> index 53184637f160..0402c498b05b 100644
> >> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> >> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> >> @@ -212,14 +212,24 @@
> >>       };
> >>   };
> >> 
> >> +&du {
> >> +    pinctrl-0 = <&du_pins>;
> >> +    pinctrl-names = "default";
> >> +    status = "okay";
> >> +
> >> +    ports {
> >> +        port@1 {
> >> +            lvds_connector: endpoint {
> > 
> > I don't understand what this unreferenced label achieves. Also, the
> > Koelsch schematics tells me LVDS is connected to DU0, not DU1...
> 
> OK, figured it out now! However in the absence of #include for a LCD
> panel this still makes little sense.

That's right, but there's no panel mounted directly on the Koelsch board, so 
we can't hardcode a particular panel model in r8a7791-koelsch.dts. This is 
where DT overlays can be handy.

-- 
Regards,

Laurent Pinchart

