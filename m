From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Dec 2015 00:24:45 +0000
Subject: Re: [PATCH 4/8 v4] thermal: rcar: retern error rcar_thermal_get_temp() if no ctemp update
Message-Id: <87egeor26y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vb895x9d.wl%kuninori.morimoto.gx@renesas.com>
	<87poyh5x69.wl%kuninori.morimoto.gx@renesas.com>
	<20151214212021.GA10992@localhost.localdomain>
In-Reply-To: <20151214212021.GA10992@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>


Hi Eduardo, again

> I believe the problem here is actually the lack of error
> handling/propagation. Are you sure you want to write to parameter
> in the fail path ?
> 
> rcar_thermal_update_temp already returns error code when it fails
> to read temperature. Don't you think it would make more sense to fix the
> places that call rcar_thermal_update_temp to properly handle its return
> value and propagate that error code when necessary?

Will update in v5
