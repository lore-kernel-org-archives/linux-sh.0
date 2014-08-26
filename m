From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Aug 2014 07:47:37 +0000
Subject: Re: [PATCH v2 02/02] ARM: shmobile: r8a7740: Multiplatform support
Message-Id: <CAMuHMdVAtwTTDjoPXXdi-mYt1qBq_pKZHaL7NyWwYVR7XgVgcw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140825033653.9284.94459.sendpatchset@w520>
In-Reply-To: <20140825033653.9284.94459.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 26, 2014 at 6:40 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Aug 26, 2014 at 11:40:12AM +0900, Simon Horman wrote:
>> On Mon, Aug 25, 2014 at 12:36:53PM +0900, Magnus Damm wrote:
>> > From: Magnus Damm <damm+renesas@opensource.se>
>> >
>> > Enable r8a7740 Multiplatform support for the generic r8a7740
>> > machine vector. No board support is enabled, and the board
>> > code for Armadillo 800 EVA DT Reference is left by itself.
>>
>> I would still like some discussion of weather using
>> #if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
>> is the best way to go.
>>
>> It seems to me that it would be cleaner to add a new Kconfig symbol or two.
>>
>> E.g. CONFIG_RMOBILE_PM which depends on CONFIG_PM and CONFIG_HAS_RMOBILE_PM
>> and then allow SoC or board Kconfig stanzas to select CONFIG_HAS_RMOBILE_PM.
>
> I am confused.
>
> I see that in "[PATCH v2 05/05] ARM: shmobile: Cleanup pm-rmobile.o build
> using Kconfig" you propose adding PM_RMOBILE but it isn't used in this
> series.

PM_RMOBILE controls the build of pm-rmobile.c, while the new #ifdefs are in the
r8a7740-specific code in pm-r8a7740.c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
