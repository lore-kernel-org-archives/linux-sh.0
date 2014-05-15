From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 May 2014 06:35:59 +0000
Subject: Re: [PATCH v3 1/2] ARM: shmobile: koelsch-reference: Remove workarounds for core clock issues
Message-Id: <CAMuHMdXV3ALbtJt1PLsfdgGUBUV02PfaK_pn2dU60+GCT=OfjA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1400078866-5694-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1400078866-5694-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thu, May 15, 2014 at 1:17 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, May 14, 2014 at 04:47:45PM +0200, Geert Uytterhoeven wrote:
>> Now the core clock issues have been fixed by commit
>> 3c90c55dcde745bed81f6447f24ba96bda43d984 ("drivers: sh: compile
>> drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI"), revert the following
>> 3 commits:
>>   - 4dcb4c80380dfa482874b931e308fd382597feab ("ARM: shmobile: Add Koelsch
>>     clock workarounds for SDHI"),
>>   - 8e4f394b20a0fe474dd88204d76978191566decf ("ARM: shmobile:
>>     koelsch-reference: Annotate clk_enables as __initconst"),
>>   - 3d75d9ea74fee6f5a4bdcbbdf2d577661d047eef ("ARM: shmobile:
>>     koelsch-reference: Work around core clock issues").
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> ---
>> This depends on 3c90c55dcde745bed81f6447f24ba96bda43d984 having landed
>> in Linus' tree
>
> Very nice. And likewise for lager.
> And I suspect we can clean up other platforms too
> (perhaps patches which haven't been queued up yet).

There are no clk_enables[] in the other platforms.

> Please repost this once the dependency hits Linus's tree.
> I will then queue it up for 3.17.

Does it really have to wait that long?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
