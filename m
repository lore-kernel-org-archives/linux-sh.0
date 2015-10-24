From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 24 Oct 2015 17:46:11 +0000
Subject: Re: [PATCH/RFC 2/6] boot-mode-reg: Add R-Car Gen2 driver
Message-Id: <CAMuHMdVhcX_=H22eUmRCuYgFERBr8JM76=u9gAbux_GK9WZ0sQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Fri, Oct 23, 2015 at 2:49 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- a/include/misc/boot-mode-reg.h
>> +++ b/include/misc/boot-mode-reg.h
>> @@ -21,4 +21,7 @@
>>  int boot_mode_reg_get(u32 *mode);
>>  int boot_mode_reg_set(u32 mode);
>>
>> +/* Allow explicit initialisation before initcalls */
>> +int rcar_gen2_init_boot_mode(void);
>> +
>
> I would move this to a separate header file.
>
> And I'd like to also get rid of it :-) Do we need this function for any
> purpose other than arch timer initialization in arch/arm/mach-shmobile/setup-
> rcar-gen2.c ? Quickly looking it that code I wonder whether we couldn't get
> the extal frequency from DT instead of the boot mode pins, which would then
> remove the dependency.

We do have the extal frequency in DT.

The boot mode pins does not control the extal frequency, but a few dividers
internal to the CPG.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
