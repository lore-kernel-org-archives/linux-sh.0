From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Feb 2011 17:43:21 +0000
Subject: Re: [PATCH 0/2] backlight support for sh_mobile_lcdcfb
Message-Id: <AANLkTimFgvrq6qMjMjZwr0RrxMQ6Fwkx6B9THzB2az4=@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1297351366-7374-1-git-send-email-gnurou@gmail.com>
In-Reply-To: <1297351366-7374-1-git-send-email-gnurou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Alexandre,

On Fri, Feb 11, 2011 at 12:22 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> These patches add initial support for per-channel GPIO-controlled backlights to the sh_mobile_lcdcfb driver. A backlight device for the ecovec24 board is also provided.

Thanks for your patches. They look surprisingly clean and nice!

The patches are mainly concerned with the Ecovec24 board - which makes
sense since that's the board you have - and you've done a good job
splitting out the code into driver changes and board specific stuff.

I'd like to use the driver portion of your code on other platforms,
but for that to work your code needs to be updated to fit other boards
as well. Mainly, not all boards control their back light with GPIO
pins. For instance, have a look at linux-2.6 git commit
170c7ab58f41c526c54e9dd04044857d5d73f9e6.

Please think about how to rework the code to allow both GPIO pins and
other types of back light control. I would simply go with some board
callbacks, but perhaps there is some overlap with the existing ones.

Cheers,

/ magnus
