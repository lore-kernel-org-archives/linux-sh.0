From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Apr 2013 08:22:15 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: add each clocks ratio on comment area
Message-Id: <CANqRtoThG8Ln-64NF0cRB_w0OQxuaLNm6+Rz80TZ7h6Z0f5RMw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ip44cc6g.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ip44cc6g.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san, Simon,

I suggest using the following commit message:

Adding comment describing the r8a7779 clock frequencies depending on
MD pin settings.

On Wed, Apr 3, 2013 at 4:20 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7779.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Acked-by: Magnus Damm <damm@opensource.se>
