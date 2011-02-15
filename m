From: Alexandre Courbot <gnurou@gmail.com>
Date: Tue, 15 Feb 2011 03:23:20 +0000
Subject: Re: [PATCH 0/2] backlight support for sh_mobile_lcdcfb
Message-Id: <AANLkTinwV6A_qYi3OUJJ=J_9xt+G1AYyX+VNBdtavQcu@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1297351366-7374-1-git-send-email-gnurou@gmail.com>
In-Reply-To: <1297351366-7374-1-git-send-email-gnurou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus, thanks for your feedback!

> I'd like to use the driver portion of your code on other platforms,
> but for that to work your code needs to be updated to fit other boards
> as well. Mainly, not all boards control their back light with GPIO
> pins. For instance, have a look at linux-2.6 git commit
> 170c7ab58f41c526c54e9dd04044857d5d73f9e6.

Indeed, I overlooked the board_cfg struct. We could have additional
backlight intensity get/set callbacks there that would mostly work
like the generic_bl driver.

> Please think about how to rework the code to allow both GPIO pins and
> other types of back light control. I would simply go with some board
> callbacks, but perhaps there is some overlap with the existing ones.

display_on and display_off callbacks currently control the backlight,
but they also turn power off when it is possible (for instance on
ap325rxa). So they could probably not be replaced by backlight
intensity settings alone. However, since backlight control will be
transferred to the LCDC driver, it should be removed from these
callbacks once the backlight device is used for the sake of
consistency.

I will try and come with a new patch sometime tomorrow!

Alex.
