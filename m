From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Aug 2014 07:44:09 +0000
Subject: Re: [PATCH v2 1/5] ARM: shmobile: r8a7740: document MSTP clock support
Message-Id: <CAMuHMdXxgYYyZz_M2975W-bPv6EEsoXp6r8QxfrvgP-Ya4q13w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1407507792-8121-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1407507792-8121-2-git-send-email-ulrich.hecht+renesas@gmail.com>
	<20140811011214.GI26570@verge.net.au>
	<20140822010400.GC2783@verge.net.au>
In-Reply-To: <20140822010400.GC2783@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Simon,

On Fri, Aug 22, 2014 at 3:04 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Aug 11, 2014 at 10:12:14AM +0900, Simon Horman wrote:
>> On Fri, Aug 08, 2014 at 04:23:08PM +0200, Ulrich Hecht wrote:
>> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>>
>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> Mike, could you consider taking this?
>
> Hi Mike,
>
> I'm wondering if you could take moment to consider this patch.
> It is a dependency for enabling ccf and in turn multiplatform on
> the r8a7740 SoC.

Sidenote: as this patch only updates the documentation, and the driver
won't use the newly added value (for now), there's no hard dependency.
Furthermore, adding this value is done following the spirit of the existing
values, and thus I think you can just continue going forward with the parts
that fall under the shmobile jurisdiction.

Thanks.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
