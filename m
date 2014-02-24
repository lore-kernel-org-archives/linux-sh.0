From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Feb 2014 14:48:35 +0000
Subject: Re: [PATCH 02/03] pinctrl: sh-pfc: r8a7791: SD1_CLK fix
Message-Id: <CACRpkdZS1HxAuuoUfNjfPbbu1xQsUzSF4aK93EDb+mL5YP8EXQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212042610.10516.36546.sendpatchset@w520>
In-Reply-To: <20140212042610.10516.36546.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 17, 2014 at 10:45 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> Hi Magnus,
>
> (CC'ing Linus Walleij)
>
> Thank you for the patch.
>
> On Wednesday 12 February 2014 13:26:10 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Fix the SD1_CLK handling for r8a7791. Without this patch
>> it is impossible to request all pins needed for SDHI1 on
>> the Koelsch board.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Since it seems I don't have this patch, if it is a fix on the critical path
please send it to me so I can apply it for fixes.

(Or if non-critical, atleast let me apply it to devel...)

Yours,
Linus Walleij
