From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 04 Nov 2014 10:24:19 +0000
Subject: Re: [PATCH v6 2/2] clk: shmobile: document DIV6 clock parent bindings
Message-Id: <CAO3366wGrHU0pYjpKxCakFLtjP-a1BLRMJXPkyphAVp-9xO5rw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415030496-26054-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1415030496-26054-3-git-send-email-ulrich.hecht+renesas@gmail.com>
	<CAMuHMdVAXFXjkim6OtvUDxCSrMQqYzc6KmE+pHUfrCfyGOZyVg@mail.gmail.com>
In-Reply-To: <CAMuHMdVAXFXjkim6OtvUDxCSrMQqYzc6KmE+pHUfrCfyGOZyVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Mike Turquette <mturquette@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Mon, Nov 3, 2014 at 6:24 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Nov 3, 2014 at 5:01 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
[...]
>> -  - clocks: Reference to the parent clock
>> +  - clocks: Reference to the parent clock(s); if there are multiple parent
>> +    clocks, one must be specified for each possible parent clock setting
>> +    in the clock register. Invalid settings must be specified as "<0>".
>> +    Trailing invalid settings may be omitted.
>
> Is there a possibility that omitting trailing invalid settings will cause 4
> or less entries for a clock with 8 parents? That would change its class,
> and the corresponding src_width and src_shift.

I checked that, and all these clocks actually have more than four
possible parents. However, ...

> So I'm inclined to say the number of parent clocks must be one of 1, 4, or 8,
> i.e. no omissions, to remove this ambiguity.

... considering that we don't know what future SoCs may bring, that
indeed looks like the better option to me.

CU
Uli
