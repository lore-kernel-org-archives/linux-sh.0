From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Sep 2009 04:20:45 +0000
Subject: Re: [PATCH] sh: Add I2C device support for EcoVec24
Message-Id: <20090911042044.GA15078@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uvdjry3vq.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uvdjry3vq.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 10, 2009 at 10:39:37AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/boards/mach-ecovec24/setup.c |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)

On Thu, Sep 10, 2009 at 10:39:48AM +0900, Kuninori Morimoto wrote:
> Kuninori Morimoto:
>       sh: add romimage-macros.h
>       sh: Add romImage support for EcoVec24
>       sh: EcoVec24: write MAC address in boot
>       sh: EcoVec24: add HIZA setting for LED
>       sh: USB disable process is needed if romImage boot for EcoVec24
>       sh: Add EcoVec24 romImage defconfig

Applied, thanks.
