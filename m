From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 03 Oct 2011 04:21:47 +0000
Subject: Re: [PATCH 4/5 v2] ARM: mach-shmobile: r8a7740: Add i2c support
Message-Id: <CANqRtoTa+uxzzVcGZMm8Fq3Z7oTpNWpisARgzh8E8v=1wfUrag@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r52ugasd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r52ugasd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, Oct 3, 2011 at 9:38 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> r8a7740 I2C needs work around
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
>
> o i2c_read/write macro doesn't include local variable
> o add unlikely()
>
> =A0arch/arm/mach-shmobile/setup-r8a7740.c | =A0102 ++++++++++++++++++++++=
++++++++++
> =A01 files changed, 102 insertions(+), 0 deletions(-)

Hi Morimoto-san,

Thanks for your work on A1 SoC support. In general I think your code
looks good and I'm also happy to see that my i2c-sh_mobile driver can
be used on yet another SoC.

The workaround in this patch, do you know exactly what you are fixing
with this patch? I wonder, is it a hardware errata workaround, or is
it a fix for a potential messy state left by the boot loader?

Perhaps the boot loader makes use of more advanced hardware features
that the linux driver doesn't suppport yet, like DMA or HighSpeed?

Have you tried resetting the I2C channels using the SRCRn registers in
the CPG? If not, please give it a go and see if it helps. If it helps
then perhaps we should work on adding some generic reset support for
the hardware blocks.

Thanks,

/ magnus
