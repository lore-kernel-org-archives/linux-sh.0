From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Aug 2015 09:16:48 +0000
Subject: Re: renesas-drivers-2015-08-11-v4.2-rc6
Message-Id: <CAMuHMdWRK=cL6iqRpDQE3gDouisEfabxKXdNquALx31S=0bwrw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1439282896-30594-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1439282896-30594-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Aug 17, 2015 at 11:11 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> I've pushed renesas-drivers-2015-08-11-v4.2-rc6 to
>> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
>> This tree is meant to ease development of platform support and drivers for
>> Renesas ARM ("shmobile") SoCs. It's created by merging (a) the for-next
>> branches of various subsystem trees and (b) branches with driver code
>> submitted or planned for submission to maintainers into the development
>> branch of Simon Horman's renesas.git tree.
>
> I noticed latest kernel can't use sound.
> It seems this commit breaks it.
>
>         0738e941ed60bf3365cbe92a9eb52198f13c13d8
>         (Merge branches 'pm-domains', 'pm-sleep' and 'pm-devfreq' into linux-next)
>
> This commit was OK
>
>         2b8b3834cb7e5b8116993d0b40f33d81f662124f
>         (Merge branch 'pm-opp' into linux-next)
>
> Are we missing something ? or bug ?

Do you see an informative difference in dmesg?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
