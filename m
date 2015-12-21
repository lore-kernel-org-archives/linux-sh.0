From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 21 Dec 2015 00:56:49 +0000
Subject: Re: [PATCH 5/8 v6] thermal: rcar: enable to use thermal-zone on DT
Message-Id: <87zix44o69.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
	<876100qzp6.wl%kuninori.morimoto.gx@renesas.com>
	<20151217203707.GD7999@localhost.localdomain>
	<87wpsctxjv.wl%kuninori.morimoto.gx@renesas.com>
	<20151219041706.GA14936@rob-hp-laptop>
In-Reply-To: <20151219041706.GA14936@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>


Hi

> > +thermal: thermal@e61f0000 {
> > +	compatible =	"renesas,thermal-r8a7790",
> > +			"renesas,rcar-gen2-thermal",
> > +			"renesas,rcar-thermal";
> 
> Isn't having both mutually exclusive?

"rcar-thermal" is very basic version of "rcar-gen2",
and "rcar-gen2" is common/basic version of "thermal-r8xxx"
