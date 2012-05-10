From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 May 2012 12:11:17 +0000
Subject: Re: [PATCH 2/2] ARM: mach-shmobile: kzm9g: enable SMP boot
Message-Id: <CANqRtoTcUy-xO6hoqZWERYRrWAV4aH+-ztm4HUoUM_VFU6H0CQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bolwpl3y.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bolwpl3y.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Morimoto-san probably intended to write this:

Update the KZM9G defconfig and the code in platsmp.c to support SMP on
the sh73a0 based KZM9G board. Also fix up the earlyprintk setting that
was previously incorrect.

On Thu, May 10, 2012 at 4:10 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch, Morimoto-san. Since you wrote such a nice change log: =)

Acked-by: Magnus Damm <damm@opensource.se>
