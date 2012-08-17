From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 17 Aug 2012 09:10:09 +0000
Subject: Re: [PATCH] ARM: shmobile: Add A4S cpuidle state on sh7372
Message-Id: <CANqRtoSh0GvUws5hj9nZvVg4wZ0zDNB+-spuWt5RTVJUNe4h0A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201208162210.31058.rjw@sisk.pl>
In-Reply-To: <201208162210.31058.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Rafael,

Thanks for your patch. Please see below for my comment.

On Fri, Aug 17, 2012 at 5:10 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> Add a "C5" cpuidle state to the SH7372 SoC connected to the A4S power
> domain in such a way that A4S may be turned off by cpuidle if all
> I/O devices in that domain have been suspended (or do not have
> attached drivers).
>
> This requires some reorganization of the initialization of SH7372
> power management which affects the the boards based on it, Mackerel
> and AP4EVB.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

[snip]

> --- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
> +++ linux/arch/arm/mach-shmobile/pm-sh7372.c
> @@ -339,6 +339,21 @@ static void sh7372_enter_a3sm_common(int
>         sh7372_set_reset_vector(__pa(sh7372_resume_core_standby_sysc));
>         sh7372_enter_sysc(pllc0_on, 1 << 12);
>  }
> +
> +static void sh7372_enter_a4s_common(int pllc0_on)
> +{
> +       sh7372_intca_suspend();
> +       sh7372_enter_sysc(pllc0_on, 1 << 10);
> +       sh7372_intca_resume();
> +}
> +
> +static void sh7372_pm_setup_smfram(void)
> +{
> +       memcpy((void *)SMFRAM, sh7372_resume_core_standby_sysc, 0x100);
> +       sh7372_set_reset_vector(SMFRAM);
> +}

I believe the reset vector is being setup dynamically depending on the
sleep mode, so you probably want to move sh7372_set_reset_vector()
into sh7372_enter_a4s_common().

Cheers,

/ magnus
