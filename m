From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 May 2013 09:07:45 +0000
Subject: Re: ARM: shmobile: r8a7778: rename device additional functio
Message-Id: <20130527090743.GB3911@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87hahp8ald.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hahp8ald.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, May 26, 2013 at 06:39:46PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> These patches rename device additional function on r8a7778.
> These are part of "I2C/HSPI/MMC support to r8a7778/BockW/defconfig",
> but, I separeted patches into small set.
> 
> Kuninori Morimoto (2):
>       ARM: shmobile: r8a7778: rename device additional function for sh-eth
>       ARM: shmobile: r8a7778: rename device additional function for sdhi

Hi Morimoto-san,

sorry to be a pain but I think these patches introduce chrun for minimal
benefit. Could you drop them an rebase your other patches accordingly?
