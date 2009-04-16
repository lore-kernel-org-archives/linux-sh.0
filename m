From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 16 Apr 2009 05:51:20 +0000
Subject: Re: [PATCH 0/6] Add support SH7724 CPU series
Message-Id: <20090416055120.GC26667@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uhc0q3ai4.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhc0q3ai4.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 15, 2009 at 11:40:19AM +0900, morimoto.kuninori@renesas.com wrote:
> SH7724 CPU support patch series
> 
> [PATCH 1/6] Add support for SH7724 CPU subtype
> [PATCH 2/6] sh-sci: Add support SH7724 support
> [PATCH 4/6 v2] Add I2C support for SH7724
> [PATCH 5/6] Add VPU support for SH7724
> [PATCH 6/6] Add VEU support for SH7724
> 
All of these have been added to the sh/shmobile-r2r-staging topic branch.
Once you have the updated USB patches and the JPU support, I'll merge
those on top of these. Once that stuff is settled, I will pull this in
to the 2.6.31 queue.
