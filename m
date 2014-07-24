From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 24 Jul 2014 12:29:09 +0000
Subject: Re: [alsa-devel] DMA engine API issue
Message-Id: <53D0FC15.6050601@metafoo.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <87d2cwvmxa.wl%kuninori.morimoto.gx@gmail.com> <3361994.F0HgAeJkR9@avalon>
 <28702317.aD0C1Ga3DS@avalon>
In-Reply-To: <28702317.aD0C1Ga3DS@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On 07/23/2014 01:07 PM, Laurent Pinchart wrote:
[...]
> Let's start by answering the background question and updating the DMA engine
> API documentation once and for good : in which context are drivers allowed to
> call the prep, tx_submit and issue_pending functions ?
>

I think the expectation is that these functions can be called in any 
context. Maybe what's missing is a way to tell the DMA engine driver to get 
ready and that it is going to be used very soon. This could be done from the 
sound devices open() callback.

- Lars
