From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Apr 2016 06:42:15 +0000
Subject: Re: [PATCH 1/7] sh: add support for J-Core J2 processor
Message-Id: <CAMuHMdXM-15324RDfrfEc0M9st+wuc6_FZKizdTBLS-Lx+REFw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <b8864269082ee9e5dcc079865340de70711b3272.1461880061.git.dalias@libc.org>
In-Reply-To: <b8864269082ee9e5dcc079865340de70711b3272.1461880061.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 29, 2016 at 2:36 AM, Rich Felker <dalias@libc.org> wrote:
> On Thu, Apr 28, 2016 at 07:12:19PM -0500, Rob Landley wrote:
>> On 03/17/2016 06:09 PM, Rich Felker wrote:
>> > Signed-off-by: Rich Felker <dalias@libc.org>
>>
>> This came through dated March 17, and thunderbird "the dumbest mail
>> client ever, except all the other ones" doesn't let me _not_ sort my
>> mailboxes anymore, so the closest I can get is sorting by date.
>>
>> Translation: this stuff got bured way back in the history and I had to
>> open the mbox file in vi just to confirm that it was a recent post and
>> not historical.
>>
>> I take it your new "git format-patch | formail" workflow has a downside? :)
>
> Sorry about that. The same should happen with git send-email though,
> no? Sorry I'm not used to the tools for sending patch series as mail
> threads rather than attachments. I can strip Date headers in the
> future and let them get regenerated, but a good MUA should sort by
> date received, not the sender's date headers.

git-send-email doesn't fake dates from commits.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
