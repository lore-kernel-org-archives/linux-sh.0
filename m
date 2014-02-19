From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Feb 2014 06:34:39 +0000
Subject: Re: [PATCH 2/3] renesas: change to using clock-indices
Message-Id: <CANqRtoSYjGuxGNnP+W8hm+ZA0kZiXM5sVF+U5ruHq7ayUPVHdA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392314571-30107-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392314571-30107-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Feb 18, 2014 at 9:14 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Tuesday 18 February 2014 10:50:07 Magnus Damm wrote:
>> On Sat, Feb 15, 2014 at 10:20 PM, Geert Uytterhoeven wrote:
>> > On Fri, Feb 14, 2014 at 3:34 PM, Laurent Pinchart wrote:
>> >>> >> Regarding how to roll it into the SoC code, I feel that this patch
>> >>> >> [2/3] and next patch [3/3] potentially causes breakage with the
>> >>> >> existing binding that was part of the v3.13 upstream kernel.
>> >>> >
>> >>> > If I'm not mistaken that's v3.14, not v3.13.
>> >>>
>> >>> Nope, it's merged in v3.13. Looked it up before sending the email. =)
>> >>
>> >> I might be missing something, but
>> >>
>> >> $ git log v3.13 --oneline -- drivers/clk/shmobile/ | wc
>> >>       0       0       0
>> >> $ git log v3.14-rc1 --oneline -- drivers/clk/shmobile/ | wc
>> >>       6      48     309
>> >
>> > It's the published bindings that count, right?
>>
>> Good question. I don't know actually.
>>
>> > Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
>> > was added in commit f94859c215b6d977794108a1a9a101239e393c09
>> > ("clk: shmobile: Add MSTP clock support").
>> >
>> > $ git tag --contains f94859c215b6d977794108a1a9a101239e393c09
>> > v3.14-rc1
>> > v3.14-rc2
>> > $
>> >
>> > Now, the bindings must be in flux, as the documentation doesn't match
>> > the code, nor the example:
>> >
>> > Documentation says:
>> >
>> > +  - renesas,indices: Indices of the gate clocks into the group (0 to 31)
>> >
>> > Example and implementation use "renesas,clock-indices":
>> >                 renesas,clock-indices = <
>> >                         R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1
>> >                         R8A7790_CLK_SDHI3
>> >                         R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1
>> >                         R8A7790_CLK_SDHI0
>> >                         R8A7790_CLK_MMCIF0
>> >                 >;
>> >
>> > Woops...
>>
>> Thanks for spotting this. I believe Laurent will fix this up in the not so
>> distant future.
>
> I plan to wait for Mike to comment on Ben's patches before addressing this.

Can you please explain about the reason behind this? I may not have
enough detailed understanding about this matter, but to me it looks
like two separate issues that somehow are combined together:

A) patch series from ben - development targeted at future merge windows
B) patch to fix inconsistency between documentation and actual code -
fix for targeted for -rc?

So regardless what the community decision is about A) we probably want
to fix B) anyway, no?

Thanks,

/ magnus
