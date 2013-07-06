From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 06 Jul 2013 03:59:06 +0000
Subject: Re: [PATCH v2 2/4] ARM: shmobile: APE6EVM: add DT reference
Message-Id: <CANqRtoTWMh9Ctc-Byc3Jwo6eJ+GK-giipno8xAe35x5Uw9+Nmg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373038006-19973-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373038006-19973-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Sat, Jul 6, 2013 at 12:26 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This patch adds a sample DT-based APE6EVM "reference" implementation. The
> use of platform-specific C-code should be avoided with this configuration
> as much as possible.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>
> v2:
> 1. merged patch 1 and the base code of patch 2 from v1 together
> 2. added the missing Makefile.boot hunk
> 3. avoid changing the general r8a73a4 DT code

This particular patch looks better, thanks.

Regarding function naming, please make sure that the same function
name style is used as for lager DT reference.

In detail, for the lager board and the r8a7790 SoC the newly added
function name is "r8a7790_add_dt_devices". As you can easily see, this
is not the same style as "r8a73a4_add_aux_devices_dt" that somehow
randonly happens to be used in this patch.

From here you have two choices.

1. Refresh your patch to use the same name style as Lager.
or
2. Discuss with simon and update Lager to use same style as you.

I don't care what you use, just use the same style.

Also, please update the order of the devices so they are registered in
the same order as Lager. You don't have to register IRQC first.

Thanks,

/ magnus
