From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 05 Dec 2008 03:40:31 +0000
Subject: Re: [PATCH] Add icb clk setting for SH7723 on sh_mobile_lcdcfb.c
Message-Id: <aec7e5c30812041940x122cd708o6ed8b7110a95aea3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uskp3tl9v.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uskp3tl9v.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Dec 5, 2008 at 12:11 PM,  <morimoto.kuninori@renesas.com> wrote:
> Thanks for checking patch.
>
>> The LCDC can be used with or without the ICB on sh7723. Right now
>> we're using it perfectly fine without the ICB.
> (snip)
>> Adding ICB support in general is a quite difficult task since there
>> are many hardware blocks that are affected. And I really think we
>> should benchmark these things to see that we implement them correctly.
>
> I can understand.
> And sorry, I had only stupid idea.

Not stupid idea. =) The ICB is just very complex.

/ magnus
