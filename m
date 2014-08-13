From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Aug 2014 11:46:22 +0000
Subject: Re: [PATCH 00/09] ARM: shmobile: Consistent use of shmobile_init_late()
Message-Id: <CAMuHMdWakLxum1rEcStdhw3rAcaS8OcNZN7npa6VhWXOU6cUcg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140730233206.5969.26669.sendpatchset@w520>
In-Reply-To: <20140730233206.5969.26669.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Tue, Aug 5, 2014 at 7:49 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Mon, Aug 4, 2014 at 10:11 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Thu, Jul 31, 2014 at 1:32 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> Make sure all mach-shmobile SoCs and DT Reference board support code
>>> call shmobile_init_late() so Suspend-to-RAM and CPUIdle get setup
>>> in a consistent way. The SoC DT case for r8a7778 and r8a7779 are
>>> also adjusted to not add any platform devices. DT shall be used instead.
>>
>> Aha, that last part was missing from the individual descriptions for
>> r8a7778 and r8a7779 ;-)
>> r8a7779_init_late() already called shmobile_init_late() internally.
>
> Right, next time I'll put more contents in the each patch!
>
>> However, r8a7778_init_late() doesn't call shmobile_init_late(). Shouldn't
>> that be added, too, to fix bockw?
>
> Maybe so, but I deem the legacy code as a lost cause. I also don't
> have any hardware access myself, so I can't test it.
>
> If you feel like it, please cook up a patch then I think Simon or
> Morimoto-san can test!

Understood. Patch sent.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
