From: Simon Horman <horms@verge.net.au>
Date: Mon, 24 Feb 2014 01:03:47 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add sound SCU clock support
Message-Id: <20140224010345.GH3898@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9dnrdbs.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87a9dnrdbs.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 18, 2014 at 07:28:11PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This is needed to use SRC (= Sampling Rate Converter).
> MSTP1017 is defined top of MSTPxxx list to avoid runtime error,
> since it is parent clock of MSTP1031 - MSTP1022
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued this up.
