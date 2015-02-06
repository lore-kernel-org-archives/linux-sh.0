From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 06 Feb 2015 11:12:13 +0000
Subject: Re: [PATCH] clk: shmobile: div6: Avoid division by zero in .round_rate()
Message-Id: <54D4A18D.3010504@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423052841-15194-1-git-send-email-geert+renesas@glider.be> <54D29760.4010009@cogentembedded.com> <54D299D6.7060809@cogentembedded.com> <4034374.lq5RZGeRAm@avalon>
In-Reply-To: <4034374.lq5RZGeRAm@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mike Turquette <mturquette@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa@sang-engineering.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 2/5/2015 8:19 PM, Laurent Pinchart wrote:

>>>>>>> Anyone may call clk_round_rate() with a zero rate value, so we have to
>>>>>>> protect against that.

>>>>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

>>>>>> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

>>>>>> I agree that this should not be fixed in the core because the fixup is
>>>>>> really driver dependant.

>>>>> Dunno, zero frequency seems generally insane to me.

>>>> It is useful to find the lowest frequency a clock can support. Basically
>>>> it is a search for the floor frequency.

>>> Why not just use 1? Or are you assuming that some hardware could actually
>>> support 0 Hz?

>> Replying to myself: yes, this has happened to me, when I forgot to override
>> the EXTAL frequency in the board .dts file (default was 0).

> So it was a good thing that the driver crashed, it let you find a bug ;-)

    None of the clock drivers crashed, but the SDHI driver hanged instead, and 
I spent much time tracing it in order to find where it hanged. :-/

WBR, Sergei

