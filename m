From: Simon Horman <horms@verge.net.au>
Date: Wed, 19 Sep 2012 00:14:03 +0000
Subject: Re: [PATCH] ARM: shmobile: fix MMCIF IRQ assignment on kzm9g
Message-Id: <20120919001403.GF12583@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1209190042440.31203@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1209190042440.31203@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Tetsuyuki Kobayashi <koba@kmckk.co.jp>, yusuke.goda.sx@renesas.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On Wed, Sep 19, 2012 at 12:52:26AM +0200, Guennadi Liakhovetski wrote:
> Error and operation IRQs are swapped in kzm9g platform data, this patch
> fixes their order. The only problem this bug causes is the confusing IRQ 
> count in /proc/interrupts output, otherwise functionality is unaffected, 
> since the driver doesn't really differentiate between the two IRQs.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks Guennadi,

as it happens I merged a very similar (same?) patch into the
fixes branch of my renesas tree yesterday. It has been accepted
by the arm-soc people and should appear in 3.6.
