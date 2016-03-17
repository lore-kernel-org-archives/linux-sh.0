From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Mar 2016 20:15:22 +0000
Subject: Re: [GIT PULL] arch/sh updates for 4.6
Message-Id: <CAMuHMdV5W15dUkbWNMBmN_BvA5vrzVcucFq6XKTmDcYvyQL+xg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317180253.GA24679@brightrain.aerifal.cx>
In-Reply-To: <20160317180253.GA24679@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich,

On Thu, Mar 17, 2016 at 8:19 PM, Rich Felker <dalias@libc.org> wrote:
> On Thu, Mar 17, 2016 at 07:52:32PM +0100, Geert Uytterhoeven wrote:
>> On Thu, Mar 17, 2016 at 7:02 PM, Rich Felker <dalias@libc.org> wrote:
>> > These are the updates Sato-san and I have for arch/sh in this merge
>> > window. Aside from some small fixes and cleanup they set the stage for
>> > J2 support (by adding framework for boards described by device tree),
>> > which should only minimally touch existing files when it's added.
>>
>> Thanks for preparing this!
>>
>> > Could you pull these changes and send them upstream for 4.6, or let me
>> > know if there are problems (like stupid mistakes I made in preparing
>> > the branch) or if I should send the request directly to Linus? Rob
>> > suggested I might go through you this first time since I'm new to
>> > maintainer workflow and the repo (on libc.org) is temporary pending
>> > getting it setup on kernel.org.
>>
>> It mostly looks fine to me.
>>
>> I have only one real comment: if you apply a patch from someone else, you
>> should add your own Signed-off-by line (use the "-s" option of "git am").
>> As your for-4.6 branch is based on current v4.5, it won't do much harm to
>> "rebase -i" it to add the missing SoB-lines.
>
> Should I do that for the ones from Sato-san too even though we're both
> listed as maintainers? The only ones I did not touch with my own SoB
> were pulled from his tree.

Yes you should, if you commit his patches to your tree.

>> I think you should send your pull request to Linus directly. You are already
>> listed as SuperH maintainer in v4.5:MAINTAINERS.
>> As your git repository is not yet on kernel.org, you best add a signed tag
>> ("git tag -s"), as Linus is reluctant to pull unsigned tags from other sites.
>
> I don't know if this will help; the reason I don't have our accounts
> setup on kernel.org yet is that I don't have my key signed by any
> kernel maintainers yet. I'm hoping to get that fixed at ELC next
> month. Do you have any recommendations for making this go smoothly
> until then?

IC.

You can always try. Chances are high Linus will be pragmatic, given the
circumstances.

If not, after ELC we'll be only at v4.6-rc3, so getting your stuff in late
shouldn't be that big of a problem.

>> After the release of v4.6-rc1, you may want to prepare a "for-next" branch
>> where you commit patches that are meant for the next (v4.7) kernel version,
>> and inform Stephen Rothwell (CCed, as he may have more advice).
>> Then your "for-next" branch will be part of "linux-next", and will receive more
>> testing. Actually it may be a good idea to create a "for-next" branch now,
>> identical to "sh-for-4.6", let it be included in "linux-next" for a few days,
>> and send the pull request to Linus afterwards. That would catch accidentally
>> introduced breakage.
>
> OK, I can do that. I don't anticipate any breakage since I haven't
> touched other archs but it can't hurt to check.

OK. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
