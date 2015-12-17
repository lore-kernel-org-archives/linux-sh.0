From: Eduardo Valentin <edubezval@gmail.com>
Date: Thu, 17 Dec 2015 20:37:08 +0000
Subject: Re: [PATCH 5/8 v5] thermal: rcar: enable to use thermal-zone on DT
Message-Id: <20151217203707.GD7999@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
 <876100qzp6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <876100qzp6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Dec 15, 2015 at 01:18:39AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch enables to use thermal-zone on DT if it was call as
> "renesas,rcar-thermal-gen2".
> Previous style is still supported by "renesas,rcar-thermal".

Could you please include also an explanation why you need to keep the
support of 'previous style'?

BR,

Eduardo 
