From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Wed, 06 May 2015 01:18:02 +0000
Subject: Re: [RFC PATCH 4/7] ARM: shmobile: r8a7790: Add nodes for pfc SD voltage regulators
Message-Id: <1430875082.4222.28.camel@xylophone.i.decadent.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	 <1430397114.5802.43.camel@xylophone.i.decadent.org.uk>
	 <20150501005719.GG13754@verge.net.au>
In-Reply-To: <20150501005719.GG13754@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@lists.codethink.co.uk

On Fri, 2015-05-01 at 09:57 +0900, Simon Horman wrote:
> Hi Ben,
> 
> thanks for your patch-set.
> 
> On Thu, Apr 30, 2015 at 01:31:54PM +0100, Ben Hutchings wrote:
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > ---
> >  arch/arm/boot/dts/r8a7790.dtsi |   21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> > index 4bb2f4c17321..23e826153a9d 100644
> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > @@ -483,6 +483,23 @@
> >  	pfc: pfc@e6060000 {
> >  		compatible = "renesas,pfc-r8a7790";
> >  		reg = <0 0xe6060000 0 0x250>;
> > +
> > +		vccq_ref_sdhi0: sd-regulator@0 {
> > +			compatible = "renesas,pfc-r8a7790-sd-regulator";
> 
> I'm a little confused. What is "renesas,pfc-r8a7790-sd-regulator"?
> It suspect that it should at least be documented under
> Documentation/devicetree/bindings/
[...]

It will be if it's agreed that this is the way to represent the voltage
switch in the pfc.  The sh-pfc driver is changed in patch 3/7 to look
for sd-regulator@{0..3} nodes in an r8a7790 DT.  The nodes carry only
their address and status.  The compatible value is currently ignored.

Ben.


