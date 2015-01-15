From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Jan 2015 11:11:37 +0000
Subject: Re: renesas-drivers-2015-01-08-v3.19-rc3
Message-Id: <CAMuHMdXwsEkeT3_wRVTKNE2jkzRmuph2zDNzqa4HeGy4gmm++w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420731718-12458-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1420731718-12458-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thu, Jan 8, 2015 at 4:49 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Jan 8, 2015 at 4:41 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> I've pushed renesas-drivers-2015-01-08-v3.19-rc3 to
>> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
>
>> Included branches with driver code:
>>   - clk-shmobile-for-3.20
>>       - clk: shmobile: div6: Avoid changing divisor in .disable()
>>       - clk: shmobile: Add r8a7793 support
>>       - clk: shmobile: r8a7793: document CPG clock support
>>       - clk: shmobile: r8a73a4 common clock framework implementation
>>       - clk: shmobile: Add r8a73a4 SoC to MSTP bindings
>>       - clk: shmobile: Add R-Car Gen2 RCAN clock support
>>       - clk: shmobile: Add R-Car Gen2 ADSP clock support
>
> Given Mike hasn't acked all commits in the list above, and there are no urgent
> hard dependencies (all depending parts are DTS changes), I think it's best if I
> ask him (instead of you) to pull this.
>
> Note that he did ack the r8a73a4 CCF parts, so these can move forward at full
> speed.
>
> Do you agree?

Ping?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
