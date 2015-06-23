From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Jun 2015 07:16:21 +0000
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Message-Id: <CAMuHMdVPs4M+4wvNHWCFKe0rxJfDPF-K+zCFgRm-MdRUY4D-Eg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael,

On Tue, Jun 23, 2015 at 1:41 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, June 22, 2015 09:31:22 AM Geert Uytterhoeven wrote:
>> If pm_genpd_{add,remove}_device() keeps on failing with -EAGAIN, we end
>> up with an infinite loop in genpd_dev_pm_{at,de}tach().
>>
>> This may happen due to a genpd.prepared_count imbalance.  This is a bug
>> elsewhere, but it will result in a system lock up, possibly during
>> reboot of an otherwise functioning system.
>>
>> To avoid this, put a limit on the maximum number of loop iterations,
>> including a simple back-off mechanism.  If the limit is reached, the
>> operation will just fail.  An error message is already printed.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This was too late for my first 4.2 pull request, but I may push it in the
> second half of the merge window.  Does it depend on anything?

Not that I'm aware of.

It applies fine on v4.1 or next-20150622.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
