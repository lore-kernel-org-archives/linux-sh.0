From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Nov 2010 04:44:10 +0000
Subject: Re: [PATCH 0/5] ARM: mach-shmobile: Add mackerel board support
Message-Id: <20101129044410.GC7594@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pipzg50rc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pipzg50rc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 29, 2010 at 11:20:23AM +0900, Kuninori Morimoto wrote:
> These are mackerel board support patches
> 
> Kuninori Morimoto (5):
>       ARM: mach-shmobile: Add mackerel board support
>       ARM: mach-shmobile: mackerel: Add SMSC support
>       ARM: mach-shmobile: mackerel: Add LCDC support
>       ARM: mach-shmobile: mackerel: Add explain comment out
>       ARM: mach-shmobile: mackerel: Add mackerel defconfig
> 
> I registered this mackerel board on ARM web site.
> These patches are based on Paul's rmobile/core tree.
> 
I've applied these to an rmobile/mackerel topic branch. I'll merge it in
to rmobile-latest once Magnus's comments have been addressed.
