From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Sep 2014 12:40:57 +0000
Subject: Re: [PATCH/RFC 4/5] ARM: shmobile: R-Mobile: Add DT support for PM domains
Message-Id: <CAMuHMdUcaGNQWmfS4U=XhksscuWh6hk8gA8fOpaUwxSmChDbiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410183344-14756-1-git-send-email-geert+renesas@glider.be>
 <1410183344-14756-5-git-send-email-geert+renesas@glider.be>
 <7h1trkkc49.fsf@deeprootsystems.com>
In-Reply-To: <7h1trkkc49.fsf@deeprootsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Tue, Sep 9, 2014 at 6:11 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> +static int r8a7740_pd_a4s_suspend(void)
>> +{
>> +     /*
>> +      * The A4S domain contains the CPU core and therefore it should
>> +      * only be turned off if the CPU is in use.
>> +      */
>> +     return -EBUSY;
>> +}
>
>
> Do you have plans to use pm_genpd_attach_cpuidle() for this eventually,
> maybe by checking if the enclosing node is a CPU?  If not, are there
> other plans to handle idle for the power domains that contain CPUs?

Yes, the plan is to add more power saving features, and use DT topology
analysis to get rid of the hardcoded domain logic.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
