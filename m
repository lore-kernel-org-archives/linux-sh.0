From: Nicolas THERY <nicolas.thery@st.com>
Date: Fri, 31 Aug 2012 09:11:15 +0000
Subject: Re: [RFC v4] V4L DT bindings
Message-Id: <50407FB3.3050209@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1208242356051.20710@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1208242356051.20710@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Benjamin GAIGNARD <benjamin.gaignard@st.com>, Willy POISSON <willy.poisson@st.com>, Jean-Marc VOLLE <jean-marc.volle@st.com>, Pierre-yves TALOUD <pierre-yves.taloud@st.com>

Hello,

On 2012-08-25 01:27, Guennadi Liakhovetski wrote:

[snip]

> 	csi2: csi2@0xffc90000 {
> 		compatible = "renesas,sh-mobile-csi2";
> 		reg = <0xffc90000 0x1000>;
> 		interrupts = <0x17a0>;
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		/* Ok to have them global? */
> 		clock-lanes = <0>;
> 		data-lanes = <2>, <1>;
> 
> 		...
> 		imx074_1: videolink@1 {
> 			reg = <1>;
> 			client = <&imx074 0>;
> 			bus-width = <2>;
> 
> 			csi2-ecc;
> 			csi2-crc;
> 
> 			renesas,csi2-phy = <0>;
> 		};
> 		ceu0: videolink@0 {
> 			reg = <0>;
> 			immutable;
> 		};
> 	};

videolink@1 makes the description of the CSI-2 rx board-specific.  Would it be
possible to keep the description of the SoC nodes board-agnostic to ease reuse
of the SoC description in multiple board DTs?

Would this be as simple as replacing &imx074 with a generic well-known name
defined in the board part of the DT?

Best regards,
Nicolas