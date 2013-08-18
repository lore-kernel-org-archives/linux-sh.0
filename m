From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 18 Aug 2013 08:32:39 +0000
Subject: Re: Build regressions/improvements in v3.11-rc2
Message-Id: <CAMuHMdVrCeZ5YPyocdvPQNQBem0X4DwO-EuygZ40zgVxa=sOMw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.02.1307232209510.32497@ayla.of.borg>
	<alpine.DEB.2.02.1307232210440.32577@ayla.of.borg>
	<20130727132915.GA3655@free.fr>
In-Reply-To: <20130727132915.GA3655@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Yann E. MORIN" <yann.morin.1998@free.fr>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Andrew Veliath <andrewtv@usa.net>, linux-kbuild <linux-kbuild@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sat, Jul 27, 2013 at 3:29 PM, Yann E. MORIN <yann.morin.1998@free.fr> wrote:
> Sorry to chime in a bit late...
>
> On 2013-07-23 22:20 +0200, Geert Uytterhoeven spake thusly:
>> On Tue, 23 Jul 2013, Geert Uytterhoeven wrote:
>> > JFYI, when comparing v3.11-rc2 to v3.11-rc1[3], the summaries are:
>> >   - build errors: +9/-23
> [--SNIP--]
>> powerpc-randconfig, due to a kconfig issue:
>>
>> Expose SCOM controllers via debugfs (SCOM_DEBUGFS) [N/y] (NEW) aborted!
>> Console input/output is redirected. Run 'make oldconfig' to update configuration
>> .
>> make[3]: *** [silentoldconfig] Error 1
>
> Can you give me instructions on how to reproduce this error?
>
> randconfig now should print the RNF seed, so that's d be nice to have to
> reproduce the error. Also, having the problematic changeset would be
> nice.

http://kisskb.ellerman.id.au/kisskb/buildresult/9148716/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
