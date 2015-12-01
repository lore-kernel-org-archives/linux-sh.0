From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 01 Dec 2015 03:00:18 +0000
Subject: Re: [PATCH] thermal: rcar: add .set_trip_temp support
Message-Id: <87r3j6yixm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a8q28wsv.wl%kuninori.morimoto.gx@renesas.com>
	<20151130185058.GA5900@localhost.localdomain>
In-Reply-To: <20151130185058.GA5900@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>, linux-kernel@vger.kernel.org, "osd2@lm.renesas.com" <osd2@lm.renesas.com>


Hi Eduardo

> According to discussion on your first version [1], this patch is not needed
> anymore, right?
> 
> If you want to add the support for writable trip points, please, add the
> support to of-thermal, as this driver supports only DT booting boards.

Thanks. I will investigate it.
