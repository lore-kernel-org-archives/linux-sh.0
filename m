From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Jul 2013 08:21:10 +0000
Subject: Re: [PATCH v3] ARM: shmobile: lager: Add DT reference
Message-Id: <CANqRtoTD3Bgm775DhFhs2kn1+sSLb-pX89mFRoHrc2x4sRT_RQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372838251-6314-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1372838251-6314-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Wed, Jul 3, 2013 at 4:57 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> This is sufficient to allow boot of the Lager board with
> a console without boards-lager.c compiled into the kernel.
> This is an example of a minimal but still useful initialisation
> of the board using DT as much as possible.
>
> As such it is the same as the boot of Lager that can be achieved
> without a board file. The intention of adding this file
> is to facilitate further work to allow board specific devices to be
> initialised via DT.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
>
> v3
> * Supply temporary machine_init call-back in lager-reference.c to
>   initialise clocks and bring up SCIF and CMT in C. Magnus
>   advised me that this is not desired in the SoC code.
> * Add lager-reference to Makefile.boot
>
> v2
> * Use recently added r8a7790_init_delay()

This looks good to me, thanks!

Acked-by: Magnus Damm <damm@opensource.se>
