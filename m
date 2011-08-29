From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 29 Aug 2011 03:36:30 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-sh73a0: tidyup CKSCR main clock selecter
Message-Id: <CANqRtoROdB-zjX8qC9VdbbGt1eU3GKAwzJmNBWtzN=KeH7pk5Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pmxozyxra.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pmxozyxra.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 26, 2011 at 4:27 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> MAINCKSEL is [29:28], not [27:24]
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This matches the data sheet, thanks for submitting this Morimoto-san.

In the future, please include the word "bug fix" in the subject so we
can tell it's a bug fix.

Thanks,

/ magnus
