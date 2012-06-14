From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Jun 2012 09:23:34 +0000
Subject: Re: [PATCH 04/27 v2] ARM: shmobile: shareing DMAEngine definitions
Message-Id: <CANqRtoRVPNsG4WeTW+H=Xd-4nsa0EeNBxZYR31iMNtbQadvrOQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871ulkyiv6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871ulkyiv6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Tue, Jun 12, 2012 at 6:33 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Current shmobile have DMAEngine specific settings on each CPU code,
> but SH-ARM DMAC use same value.
> This patch will share DMAEngine definitions and reduce a waste of code
> on SH-ARM architecture.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Simon Horman <horms@verge.net.au>
> ---
> v1 -> v2

Hi Morimoto-san,

Thanks for your efforts to reduce code redundancy.

> =A0arch/arm/mach-shmobile/include/mach/dma-register.h | =A0 45 +++++++++++

Are these new shared constants really limited to the ARM architecture?
Can't they be shared with SH? If so then they should be in include/
instead of arch/arm/include/.

Cheers,

/ magnus
