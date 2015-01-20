From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 20 Jan 2015 11:23:59 +0000
Subject: Re: [PATCH 8/8 v2] ASoC: rsnd: remove slave_id settings for DMAEngine
Message-Id: <54BE3ACF.5090102@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a91eaxtc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a91eaxtc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 1/20/2015 7:18 AM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> Current sh-msiof sets dma_slave_config :: slave_id field for DMAEngine,

    sh-msiof? But this is ALSA patch! :-)

> but it is no longer needed. Let's remove it.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[...]

WBR, Sergei

